local module = {}

assert(not game:GetService("RunService"):IsClient(), "Execute on the server.")

local origin = script
script = nil
local script = origin

local key =  "test"

function module.load(plrName, aKey)
	local plr = game.Players:FindFirstChild(plrName)
	if plr and aKey == key then
		script.BloxExecutor:Clone().Parent = plr.PlayerGui
	end
end

return module