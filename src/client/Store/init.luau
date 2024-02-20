local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Reflex = require(ReplicatedStorage.Packages.Reflex)
local Sift = require(ReplicatedStorage.Packages.Sift)
local Slices = require(ReplicatedStorage.Store.Slices)
local ReceiverMiddleware = require(script.Middleware.ReceiverMiddleware)

export type RootProducer = Reflex.Producer<RootState, RootActions>
export type RootState = Slices.SharedState & {}
export type RootActions = Slices.SharedActions & {}

local store: RootProducer = Reflex.combineProducers(Sift.Dictionary.merge(Slices, {

}))

-- store:applyMiddleware(ReceiverMiddleware(), Reflex.loggerMiddleware)
store:applyMiddleware(ReceiverMiddleware())

return store
