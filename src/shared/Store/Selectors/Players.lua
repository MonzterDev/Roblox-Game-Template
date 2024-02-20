local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)

local Slices = require(ReplicatedStorage.Store.Slices)
local PlayersSlice = require(ReplicatedStorage.Store.Slices.Players)

local function SelectPlayerBalances(playerId: string)
    return function(state: Slices.SharedState)
        return state.players.balance[playerId]
    end
end

local function SelectPlayerData(playerId: string)
    return Reflex.createSelector(
        SelectPlayerBalances(playerId),

        function(balance: PlayersSlice.PlayerBalance?): PlayersSlice.PlayerData?
            if not balance then
                return
            end

            return {
                balance = balance
            }
        end
    )
end

return {
    SelectPlayerBalance = SelectPlayerBalances,
    SelectPlayerData = SelectPlayerData,
}
