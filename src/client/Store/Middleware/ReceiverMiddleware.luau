local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Net = require(ReplicatedStorage.Packages.Net)
local Remotes = require(ReplicatedStorage.Remotes)

local function receiverMiddleware()
	local start = Remotes.Client:Get("start") :: Net.ClientSenderEvent
	local broadcast = Remotes.Client:Get("broadcast") :: Net.ClientListenerEvent

	local receiver = Reflex.createBroadcastReceiver({
		start = function(): ()
			start:SendToServer()
		end,
	})

	broadcast:Connect(function(actions)
		receiver:dispatch(actions)
	end)

	return receiver.middleware
end

return receiverMiddleware
