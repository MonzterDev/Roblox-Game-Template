local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

return Net.CreateDefinitions({
    broadcast = Net.Definitions.ServerToClientEvent(),
    start = Net.Definitions.ClientToServerEvent(),
})
