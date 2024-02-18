local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ServerScriptService = game:GetService("ServerScriptService")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local ProfileStore = require(ServerScriptService.Packages.ProfileService)
local PlayerData = require(ReplicatedStorage.Configs.PlayerData)
local Store = require(ServerScriptService.Store)
local Selectors = require(ReplicatedStorage.Store.Selectors)

local DATASTORE_NAME = "Production"

if RunService:IsStudio() then
    DATASTORE_NAME = "Development"
end

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

    task.spawn(function()
        while true do
            for _, player in Players:GetPlayers() do
                Store.updateBalance(tostring(player.UserId), "coins", 1)
            end
            task.wait(1)
        end
    end)
end

function Local.SetupLeaderstats(player: Player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local coins = Instance.new("NumberValue", leaderstats)
    coins.Name = "Coins"

    local gems = Instance.new("NumberValue", leaderstats)
    gems.Name = "Gems"

    local selector = Selectors.SelectPlayerBalance(tostring(player.UserId))
    local unsubscribe = Store:subscribe(selector, function(balance)
        coins.Value = balance.coins or 0
        gems.Value = balance.gems or 0
    end)
    Players.PlayerRemoving:Connect(function(leavingPlayer: Player)
        if leavingPlayer == player then
            unsubscribe()
        end
    end)
end

function Local.CreateProfile(player: Player)
    local profile = Local.ProfileStore:LoadProfileAsync(`Player_{player.UserId}`)
    if not profile then return end

    profile:ListenToRelease(function()
        Local.Profiles[player.UserId] = nil
        Store.closePlayerData(tostring(player.UserId))
        player:Kick()
    end)

    profile:AddUserId(player.UserId)
    profile:Reconcile()

    Local.Profiles[player.UserId] = profile
    Store.loadPlayerData(tostring(player.UserId), profile.Data)
    Local.SetupLeaderstats(player)

    local selector = Selectors.SelectPlayerData(tostring(player.UserId))
    local unsubscribe = Store:subscribe(selector, function(playerData)
        if playerData then
            profile.Data = playerData
        end
    end)
    Players.PlayerRemoving:Connect(function(leavingPlayer: Player)
        if leavingPlayer == player then
            unsubscribe()
        end
    end)
end

function Local.RemoveProfile(player: Player)
    local profile = Local.Profiles[player.UserId]
    if not profile then return end

    profile:Release()
end

return Shared
