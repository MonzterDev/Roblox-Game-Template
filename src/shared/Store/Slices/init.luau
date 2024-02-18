local players = require(script.Players)

export type SharedState = {
    players: players.PlayersState
}

export type SharedActions = players.PlayersActions

return {
    players = players.playersSlice
}
