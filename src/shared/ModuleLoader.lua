local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local RunService = game:GetService("RunService")

local IsServer = RunService:IsServer()
local RootDirectory = if IsServer then ServerScriptService else Players.LocalPlayer:WaitForChild("PlayerScripts")
local ModuleDirectory = if IsServer then RootDirectory.Services else RootDirectory:WaitForChild("Controllers")

local function RequireModule(module: ModuleScript)
    if not module:IsA("ModuleScript") then
        return
    end

    local import = require(module)

    local onStart = import.OnStart
    if onStart then
        task.spawn(onStart)
    end
end

return function()
    for _, descendant: ModuleScript in ModuleDirectory:GetDescendants() do
        RequireModule(descendant)
    end

    if not IsServer then
        ModuleDirectory.DescendantAdded:Connect(function(descendant: ModuleScript)
            RequireModule(descendant)
        end)
    end
end
