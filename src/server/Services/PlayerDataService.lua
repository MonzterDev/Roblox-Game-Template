local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local ProfileStore = require(ServerScriptService.Packages.ProfileService)
local PlayerData = require(ReplicatedStorage.Configs.PlayerData)
local UpdateState = require(ReplicatedStorage.Functions.UpdateState)
local Remotes = ReplicatedStorage.Remotes.PlayerData

local DATASTORE_NAME = "Production"

if RunService:IsStudio() then
    DATASTORE_NAME = "Development"
end

export type UpdateDataAction = UpdateState.UpdateStateAction

type Profiles = {
    [number]: ProfileStore.Profile<PlayerData.PlayerData, {}, {}>
}

local Profiles: Profiles = {}

local Local = {}
local Shared = {}

Local.ProfileStore = ProfileStore.GetProfileStore(DATASTORE_NAME, PlayerData)
Local.Profiles = Profiles

function Shared.OnStart()
    Players.PlayerAdded:Connect(Local.CreateProfile)
    Players.PlayerRemoving:Connect(Local.RemoveProfile)

    for _, player in Players:GetPlayers() do
        Local.CreateProfile(player)
    end

    Remotes.Start.OnServerEvent:Connect(function(player: Player)
        local profile = Local.Profiles[player.UserId]
        if not profile then return end

        Remotes.SetData:FireClient(player, profile.Data)
    end)

    task.spawn(function()
        while true do
            for _, player in Players:GetPlayers() do
                local updateBalance: UpdateState.UpdateStateAction = {
                    action = "UpdateBalance",
                    currency = "coins",
                    amount = 1
                }
                Shared.UpdateState(player, updateBalance)
            end
            task.wait(1)
        end
    end)
end

function Shared.UpdateState(player: Player, action: UpdateState.UpdateStateAction)
    local profile = Local.Profiles[player.UserId]
    if not profile then return end

    local leaderstats = player:FindFirstChild("leaderstats")
    if leaderstats then
        if action.action == "UpdateBalance" then
            local capitalizedCurrency = action.currency:gsub("^%l", string.upper)
            local value = leaderstats:FindFirstChild(capitalizedCurrency)
            if value then
                value.Value += action.amount
            end
        end
    end

    UpdateState(profile.Data, action)
    Remotes.UpdateData:FireClient(player, action)
end

function Local.GetState(player: Player): UpdateState.PlayerData?
    local profile = Local.Profiles[player.UserId]
    if not profile then return end

    return profile.Data
end

function Local.SetupLeaderstats(player: Player, data: PlayerData.PlayerData)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local coins = Instance.new("NumberValue", leaderstats)
    coins.Name = "Coins"
    coins.Value = data.balance.coins

    local gems = Instance.new("NumberValue", leaderstats)
    gems.Name = "Gems"
    gems.Value = data.balance.gems
end

function Local.CreateProfile(player: Player)
    local profile = Local.ProfileStore:LoadProfileAsync(`Player_{player.UserId}`)
    if not profile then return end

    profile:ListenToRelease(function()
        Local.Profiles[player.UserId] = nil
        player:Kick()
    end)

    profile:AddUserId(player.UserId)
    profile:Reconcile()

    Local.Profiles[player.UserId] = profile
    Local.SetupLeaderstats(player, profile.Data)
    Remotes.SetData:FireClient(player, profile.Data)
end

function Local.RemoveProfile(player: Player)
    local profile = Local.Profiles[player.UserId]
    if not profile then return end

    profile:Release()
end

return Shared
