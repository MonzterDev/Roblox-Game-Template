local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GuiController = require(script.Parent.Parent.GuiController)
local Store = require(script.Parent.Parent.Parent.Store)
local Selectors = require(ReplicatedStorage.Store.Selectors)

local Player = Players.LocalPlayer

local Gui = GuiController.Guis.Currency
local Frame = Gui.Frame

local Local = {}
local Shared = {}

function Shared.OnStart()
    local selector = Selectors.SelectPlayerBalance(tostring(Player.UserId))

    local unsubscribe = Store:subscribe(selector, function(balance)
        Frame.Coins.Amount.Text = balance.coins or 0
        Frame.Gems.Amount.Text = balance.gems or 0
    end)
end

return Shared
