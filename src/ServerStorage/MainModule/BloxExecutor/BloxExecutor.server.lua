--[[
	BloxExecutor server side
	
	FOR ROBLOX STAFF WHO ARE READING THIS:
	If theres a problem (wether it's a inappropriate script problem or anything), please email me INSTEAD OF BANNING ME.
	So I will remove it.
--]]

--// Services
local serverScriptService = game:GetService("ServerScriptService")
local logService = game:GetService("LogService")

--// Grab libraries
local originScript = script
local library = originScript.Parent.Library
--local R6Converter = require(5440751352)
local scriptLoadstring = require(library.Loadstring)

--// Player
local plr = script.Parent.Parent.Parent --// This script should be parented at PlayerGui

--// Security stuff
--getmetatable().script = nil
script = nil

--// RemoteEvent
local remote = Instance.new("RemoteFunction")
remote.Name = "bloxExecutor"
remote.Parent = originScript.Parent

local logRemote = Instance.new("RemoteEvent")
logRemote.Name = "bloxExecutorLog"
logRemote.Parent = originScript.Parent

originScript.Parent.BloxExecutorClient.Disabled = false

remote.OnServerInvoke = function(aPlr, action, code, players)
	if (aPlr == plr) then
		if action == "executeCode" then
			local success, errorMsg = pcall(function()
				scriptLoadstring(code)()
			end)
			
			if success then
				return true
			else
				return false, errorMsg
			end
		--elseif action == "bulkExecuteCode" then
		--	if typeof(players) == "table" then
		--		for _, v in pairs(players) do
		--			pcall(function()
		--				scriptLoadstring(code)()
		--			end)
		--		end
		--	end
		end
	else
		return error("You cannot fire this remote.")
	end
end

--// Log service [DISABLED]
--[[
logService.MessageOut:Connect(function(message, msgType)
	logRemote:FireClient(plr, message, msgType)
end)
--]]