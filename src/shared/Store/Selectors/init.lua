local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Sift = require(ReplicatedStorage.Packages.Sift)

local Players = require(script.Players)

return Sift.Dictionary.merge(Players) :: typeof(Players)
