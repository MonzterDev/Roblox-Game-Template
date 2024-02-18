local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Store = require(ServerScriptService.Store)
local PlayerData = require(ReplicatedStorage.Configs.PlayerData)

return function (context, currency: PlayerData.Currency, amount: number, player: Player?)
    player = if player then player else context.Executor
    Store.updateBalance(tostring(player.UserId), currency, amount)
end
