local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerData = require(ReplicatedStorage.Configs.PlayerData)

export type UpdateStateAction =
    {
        action: "UpdateBalance",
        currency: PlayerData.Currency,
        amount: number
    }

export type PlayerData = PlayerData.PlayerData

return function (data: PlayerData.PlayerData, action: UpdateStateAction)
    if action.action == "UpdateBalance" then
        data.balance[action.currency] += action.amount
    end

    return data
end
