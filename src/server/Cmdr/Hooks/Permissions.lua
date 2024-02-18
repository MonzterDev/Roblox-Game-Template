local OWNER_ID = 811308495

local ALLOWED_USER_IDS = {
    OWNER_ID
}

return function (registry)
	registry:RegisterHook("BeforeRun", function(context)
        local isUserAllowed = table.find(ALLOWED_USER_IDS, context.Executor.UserId)
		if context.Group == "Admin" and not isUserAllowed then
			return "You don't have permission to use this command!"
		end
	end)
end
