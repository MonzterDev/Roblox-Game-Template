local StateController = require(script.Parent.StateController)
local GuiController = require(script.Parent.GuiController)

local Gui = GuiController.Guis.Currency
local Frame = Gui.Frame

local Local = {}
local Shared = {}

function Shared.OnStart()
    StateController.UpdateState.Event:Connect(function(action: StateController.UpdateDataAction, newState: StateController.PlayerData)
        local shouldUpdate = action.action == "UpdateBalance"
        if shouldUpdate then
            Local.UpdateCurrencyUI(action, newState)
        end
    end)
end

function Local.UpdateCurrencyUI(action: StateController.UpdateDataAction, newState: StateController.PlayerData)
    local capitalizedCurrency = action.currency:gsub("^%l", string.upper)
    local newAmount = newState.balance[action.currency]
    Frame[capitalizedCurrency].Amount.Text = tostring(newAmount)
end

return Shared
