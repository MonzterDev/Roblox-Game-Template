local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Net = require(ReplicatedStorage.Packages.Net)

return Net.CreateDefinitions({
    broadcast = Net.Definitions.ServerToClientEvent(),
    start = Net.Definitions.ClientToServerEvent(),

    Start = Net.Definitions.ClientToServerEvent(),
    SetData = Net.Definitions.ServerToClientEvent(),
    UpdateData = Net.Definitions.ServerToClientEvent(),
})
