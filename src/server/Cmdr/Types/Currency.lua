local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerData = require(ReplicatedStorage.Configs.PlayerData)

local currencies = {}

for currency, _ in PlayerData.balance do
	table.insert(currencies, currency)
end

return function (registry)
	registry:RegisterType("currency", registry.Cmdr.Util.MakeEnumType("currency", currencies))
end
