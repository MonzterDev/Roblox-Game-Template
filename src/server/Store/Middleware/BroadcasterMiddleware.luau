local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Net = require(ReplicatedStorage.Packages.Net)
local Remotes = require(ReplicatedStorage.Remotes)
local Slices = require(ReplicatedStorage.Store.Slices)

local function broadcasterMiddleware()
	local broadcast = Remotes.Server:Get("broadcast") :: Net.ServerSenderEvent
	local start = Remotes.Server:Get("start") :: Net.ServerListenerEvent

	local broadcaster = Reflex.createBroadcaster({
		producers = {
			players = Slices.players.playersSlice
		},

		dispatch = function(player, actions)
			broadcast:SendToPlayer(player, actions)
		end
	})

	start:Connect(function(player)
		return broadcaster:start(player)
	end)

	return broadcaster.middleware
end

return broadcasterMiddleware
