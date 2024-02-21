local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Sift = require(ReplicatedStorage.Packages.Sift)

local PlayerData = require(ReplicatedStorage.Configs.PlayerData)

type BalanceProducer = Reflex.Producer<BalanceState, BalanceActions>

export type BalanceState = {
    [string]: PlayerData.PlayerBalance
}

export type BalanceActions = {
    loadPlayerData: (playerId: string, data: PlayerData.PlayerBalance) -> (),
    closePlayerData: (playerId: string) -> (),
    updateBalance: (playerId: string, currency: PlayerData.Currency, amount: number) -> (),
}

local initialState: BalanceState = {}

local balanceSlice: BalanceProducer = Reflex.createProducer(initialState, {
    loadPlayerData = function(state, playerId: string, data: PlayerData.PlayerData)
        return Sift.Dictionary.set(state, playerId, data.balance)
    end,

    closePlayerData = function(state, playerId: string)
        return Sift.Dictionary.removeKey(state, playerId)
    end,

    updateBalance = function(state, playerId: string, currency: PlayerData.Currency, amount: number)
        return Sift.Dictionary.update(state, playerId, function(balance: PlayerData.PlayerBalance)
            if not balance then
                return
            end

            return Sift.Dictionary.set(balance, currency, balance[currency] + amount)
        end)
    end,
})

return balanceSlice
