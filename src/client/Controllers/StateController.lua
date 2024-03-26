local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UpdateState = require(ReplicatedStorage.Functions.UpdateState)
local Remotes = ReplicatedStorage.Remotes.PlayerData

export type UpdateDataAction = UpdateState.UpdateStateAction
export type PlayerData = UpdateState.PlayerData

local State: UpdateState.PlayerData?

local Local = {}
local Shared = {}

Shared.UpdateState = Instance.new("BindableEvent")

function Shared.OnStart()
    Remotes.SetData.OnClientEvent:Connect(function(data: UpdateState.PlayerData)
        if State then
            return
        end

        State = data
    end)

    Remotes.UpdateData.OnClientEvent:Connect(function(action: UpdateState.UpdateStateAction)
        if not State then
            return
        end

        UpdateState(State, action)
        Shared.UpdateState:Fire(action, State)
    end)

    Remotes.Start:FireServer()
end

function Shared.GetState(): UpdateState.PlayerData
    while State == nil do
        -- We do this to prevent any errors resulting from using our state before it's been set (usually from guis upon starting the game)
        task.wait(0.01)
    end

    return State
end

return Shared
