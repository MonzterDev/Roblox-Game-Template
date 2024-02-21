local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Cmdr = require(ReplicatedStorage:WaitForChild("CmdrClient"))

local ACTIVATION_KEYS = {
    Enum.KeyCode.F2,
    Enum.KeyCode.Semicolon
}

Cmdr:SetActivationKeys(ACTIVATION_KEYS)
