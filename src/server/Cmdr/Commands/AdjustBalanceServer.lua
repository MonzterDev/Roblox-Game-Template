local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local PlayerData = require(ReplicatedStorage.Configs.PlayerData)
local PlayerDataService = require(ServerScriptService.Services.PlayerDataService)

return function (context, currency: PlayerData.Currency, amount: number, player: Player?)
    player = if player then player else context.Executor
    local updateBalance: PlayerDataService.UpdateDataAction = {
        action = "UpdateBalance",
        currency = currency,
        amount = amount
    }
    PlayerDataService.UpdateState(player, updateBalance)
end
