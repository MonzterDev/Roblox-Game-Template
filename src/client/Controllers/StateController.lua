local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UpdateState = require(ReplicatedStorage.Functions.UpdateState)
local Remotes = require(ReplicatedStorage.Remotes)

export type UpdateDataAction = UpdateState.UpdateStateAction
export type PlayerData = UpdateState.PlayerData

local State: UpdateState.PlayerData?

local Local = {}
local Shared = {}

Shared.UpdateState = Instance.new("BindableEvent")

function Shared.OnStart()
    Remotes.Client:Get("SetData"):Connect(function(data: UpdateState.PlayerData)
        if State then
            return
        end

        State = data
    end)

    Remotes.Client:Get("UpdateData"):Connect(function(action: UpdateState.UpdateStateAction)
        if not State then
            return
        end

        UpdateState(State, action)
        Shared.UpdateState:Fire(action, State)
    end)

    Remotes.Client:Get("Start"):SendToServer()
end

function Shared.GetState(): UpdateState.PlayerData
    while State == nil do
        -- We do this to prevent any errors resulting from using our state before it's been set (usually from guis upon starting the game)
        task.wait(0.1)
    end

    return State
end

return Shared
