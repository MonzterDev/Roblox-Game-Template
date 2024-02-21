local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)

local PlayerData = require(ReplicatedStorage.Configs.PlayerData)
local Balance = require(script.Balance)

export type PlayerData = PlayerData.PlayerData
export type PlayerBalance = PlayerData.PlayerBalance

type PlayersProducer = Reflex.Producer<PlayersState, PlayersActions>

export type PlayersState = {
    balance: Balance.BalanceState
}

export type PlayersActions = Balance.BalanceActions

local playersSlice: PlayersProducer = Reflex.combineProducers({
    balance = Balance,
})

return {
    playersSlice = playersSlice,
    template = PlayerData
}
