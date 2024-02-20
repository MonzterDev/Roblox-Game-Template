local Players = game:GetService("Players")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local Local = {}
local Shared = {}

Shared.Guis = {
    Currency = PlayerGui:WaitForChild("Currency"),
}

return Shared
