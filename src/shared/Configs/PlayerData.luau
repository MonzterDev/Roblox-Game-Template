export type Currency = "coins" | "gems"

export type PlayerBalance = {
    coins: number,
    gems: number,
}

export type PlayerData = {
    balance: PlayerBalance
}

local PlayerData: PlayerData = {
    balance = {
        coins = 0,
        gems = 0,
    }
}

return PlayerData
