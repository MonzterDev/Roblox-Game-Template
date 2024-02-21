local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Sift = require(ReplicatedStorage.Packages.Sift)
local Slices = require(ReplicatedStorage.Store.Slices)
local BroadcasterMiddleware = require(script.Middleware.BroadcasterMiddleware)

export type RootProducer = Reflex.Producer<RootState, RootActions>
export type RootState = Slices.SharedState & {}
export type RootActions = Slices.SharedActions & {}

local store: RootProducer = Reflex.combineProducers(Sift.Dictionary.merge(Slices), {

})

-- store:applyMiddleware(BroadcasterMiddleware(), Reflex.loggerMiddleware)
store:applyMiddleware(BroadcasterMiddleware())

return store
