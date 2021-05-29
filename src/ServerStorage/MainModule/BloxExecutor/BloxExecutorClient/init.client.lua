--[[
	BloxExecutor client side
	
	FOR ROBLOX STAFF WHO ARE READING THIS:
	If theres a problem (wether it's a inappropriate script problem or anything), please email me INSTEAD OF BANNING ME.
	So I will remove it.
--]]

--// Service
local tweenService = game:GetService("TweenService")
local logService = game:GetService("LogService")
local textService = game:GetService("TextService")

--// Variables
local originScript = script
local gui = script.Parent
local frame = gui:WaitForChild("MainFrame")

local mainRemote
local logRemote
local loadingFrame = gui:WaitForChild("Loading")
local actionText = loadingFrame:WaitForChild("Action")
local dialog = originScript:WaitForChild("Dialog_nil"):Clone()
local utility = {}

local isLogFrameOpen, isScriptHubOpen = false, true

function utility.startDraggableService(frame)
	local UserInputService = game:GetService("UserInputService")
	
	local gui = frame
	
	local dragging
	local dragInput
	local dragStart
	local startPos
	
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position
			
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	
	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

function utility.tableToText(aTable)
	if typeof(aTable) == "table" then
		local text =  ""
		for _, v in ipairs(aTable) do
			if text == "" or text == " " then
				text = v
			else
				text = text.."\n"..v
			end
		end
		return text
	end
end

function utility.showDialog(title, content)
	local clonedDialog = dialog:Clone()
	clonedDialog.Name = "Dialog_"..title
	clonedDialog.Title.Text = title
	clonedDialog.Content.Text = content
	clonedDialog.Close.MouseButton1Click:Connect(function()
		clonedDialog:Destroy()
	end)
	clonedDialog.Visible = true
	clonedDialog.Parent = gui
	utility.startDraggableService(clonedDialog)
end

--// Loading
actionText.Text = "Loading.. (Waiting for remotes)"
mainRemote = gui:WaitForChild("bloxExecutor")
--logRemote = gui.Parent:WaitForChild("bloxExecutorLog")

actionText.Text = "Loading.. (Setting up remotes)"
--[[
local logData = {
	serverLogs = {},
	clientLogs =  {},
	mode = "server"
}
--]]
local logFrame = gui:WaitForChild("LogFrame")
local logText = logFrame:WaitForChild("LogScrollingFrame"):WaitForChild("Log")
--[[
logRemote.OnClientEvent:Connect(function(message, msgType)
	
	if tostring(message) and msgType == Enum.MessageType.MessageOutput and not logData.serverLogs ~= nil then
		logData.serverLogs = table.insert(logData.serverLogs, "[Output]: "..message)
	elseif msgType == Enum.MessageType.MessageError and not logData.serverLogs ~= nil  then
		logData.serverLogs = table.insert(logData.serverLogs, "[Error]: "..message)
	elseif msgType == Enum.MessageType.MessageWarning and not logData.serverLogs ~= nil  then
		logData.serverLogs = table.insert(logData.serverLogs, "[Warning]: "..message)
	elseif msgType == Enum.MessageType.MessageInfo and not logData.serverLogs ~= nil  then
		logData.serverLogs = table.insert(logData.serverLogs, "[Info]: "..message)
	end
	
	if message ~= nil then
		table.insert(logData.serverLogs, message)
	end
	if logData.mode == "server" and not logData.serverLogs ~= nil  then
		logText.Text = utility.tableToText(logData.serverLogs)
	end
end)
--]]
actionText.Text = "Loading.. (Waiting for Loadstring)"
local systemLoadstring = require(gui:WaitForChild("Library"):WaitForChild("Loadstring"))

actionText.Text = "Loading.. (Waiting for server)"

actionText.Text = "Loading.. (Waiting for gui)"
local textBox = frame:WaitForChild("TextBoxScrollingFrame"):WaitForChild("Source")
local executeBtn = frame:WaitForChild("Execute")
local modeBtn = frame:WaitForChild("Mode")
local clearBtn = frame:WaitForChild("Clear")
local closeBtn = frame:WaitForChild("Close")
local logBtn = frame:WaitForChild("Logs")
local openBtn = gui:WaitForChild("Open")

local textBoxLines = textBox.Parent:WaitForChild("Lines")

local logModeBtn = logFrame:WaitForChild("Mode")
local logCloseBtn = logFrame:WaitForChild("Close")

local scriptHubFrame = gui:WaitForChild("ScriptHub")

actionText.Text = "Setting up.. (Executor setup)"

local executeSide = "server"

--// Security
--getmetatable().script = nil
script = nil

utility.startDraggableService(frame)
utility.startDraggableService(logFrame)
utility.startDraggableService(openBtn)
utility.startDraggableService(scriptHubFrame)


textBox:GetPropertyChangedSignal("TextBounds"):Connect(function() --// I got confused when making this part
	local textBounds = textBox.TextBounds
	if textBounds.X < 497 and textBounds.Y < 173 then return end
	if textBounds.X < 497 and textBounds.Y > 173 then
		textBox.Parent.CanvasSize = UDim2.new(0, 497, 0, textBounds.Y)
		textBox.Size = UDim2.new(0, 462, 0, textBounds.Y)
		textBoxLines.Size = UDim2.new(0, 30, 0, textBounds.Y)
	elseif textBounds.X > 497 and textBounds.Y < 173 then
		textBox.Parent.CanvasSize = UDim2.new(0, textBounds.X, 0, 173)
		textBox.Size = UDim2.new(0, textBounds.X, 0, 172)
		textBoxLines.Size = UDim2.new(0, 30, 0, 172)
	else
		textBox.Parent.CanvasSize = UDim2.new(0, textBounds.X, 0, textBounds.Y)
		textBox.Size = UDim2.new(0, textBounds.X, 0, textBounds.Y)
		textBoxLines.Size = UDim2.new(0, 30, 0, textBounds.Y)
	end
end)

executeBtn.MouseButton1Click:Connect(function()
	if executeSide == "server" then
		local success, errorMsg = mainRemote:InvokeServer("executeCode", textBox.Text)
		if not success then
			utility.showDialog("Script error", errorMsg)
		end
	else
		local success, errorMsg = pcall(function()
			systemLoadstring(textBox.Text)()
		end)
		if not success then
			utility.showDialog("Script error", errorMsg)
		end
	end
end)

modeBtn.MouseButton1Click:Connect(function()
	if executeSide == "server" then
		executeSide = "client"
		modeBtn.Text = "Mode: Client"
	else
		executeSide = "server"
		modeBtn.Text = "Mode: Server"
	end
end)

clearBtn.MouseButton1Click:Connect(function()
	textBox.Text = "-- Code here"
	textBox.Parent.CanvasSize = UDim2.new(0, 0, 0, 0)
	textBox.Size = UDim2.new(0, 462, 0, 172)
	textBoxLines.Size = UDim2.new(0, 30, 0, 172)
end)

closeBtn.MouseButton1Click:Connect(function()
	frame.Visible = false
	logFrame.Visible = false
	scriptHubFrame.Visible = false
	openBtn.Visible = true
end)

logCloseBtn.MouseButton1Click:Connect(function()
	logFrame.Visible = false
end)

openBtn.MouseButton1Click:Connect(function()
	frame.Visible = true
	openBtn.Visible = false
	if isScriptHubOpen then
		scriptHubFrame.Visible = true
	end
end)

--[[
logData.clientLogs = logService:GetLogHistory()
logService.MessageOut:Connect(function(msg, msgType)
	if tostring(msg) and msgType == Enum.MessageType.MessageOutput then
		table.insert(logData.clientLogs, "[Output]:  "..msg)
	elseif msgType == Enum.MessageType.MessageError then
		table.insert(logData.clientLogs, "[Error]:  "..msg)
	elseif msgType == Enum.MessageType.MessageWarning then
		table.insert(logData.clientLogs, "[Warning]:  "..msg)
	elseif msgType == Enum.MessageType.MessageInfo then
		table.insert(logData.clientLogs, "[Info]:  "..msg)
	end
	
	if logData.mode ~= "server" then
		logText.Text = utility.tableToText(logData.clientLogs)
	end
end)

logModeBtn.MouseButton1Click:Connect(function()
	if logData.mode == "server" then
		logText.Text = utility.tableToText(logData.serverLogs)
	else
		logText.Text = utility.tableToText(logData.clientLogs)
	end
end)

logBtn.MouseButton1Click:Connect(function()
	logFrame.Visible = true
end)
--]]

actionText.Text = "Setting hub.. (Script hub setup)"

--// Script Hub start
function utility.getPlayer(playerName)
	if string.lower(playerName) == "me" then
		return {game.Players.LocalPlayer}
	elseif string.lower(playerName) == "all" then
		return game.Players:GetPlayers()
	elseif string.lower(playerName) == "others" then
		local a = {}
		for _, v in pairs(game.Players:GetPlayers()) do
			if v.Name ~= game.Players.LocalPlayer.Name then
				table.insert(a, v)
			end
		end
	else
		for _, v in pairs(game.Players:GetPlayers()) do
			if v.Name == playerName then
				return {v}
			end
		end
	end
end

local playerNameTextBox = scriptHubFrame:WaitForChild("PlayerName")

--// Assets
local dummyCreatorModule = "5469049050"
local archAngelModule = "REDACTED"
local r6ConverterModule = "3068366282"
local ascendModule = "REDACTED"
local rainingZeroTwoModule = "REDACTED"
local private123jlStuffModule = "REDACTED"
local theSunIsADeadlyLazerModule = "REDACTED"
local serverAdminModule = "REDACTED"
local theBigOwOModule = "REDACTED"

--// Close button
scriptHubFrame:WaitForChild("Close").MouseButton1Click:Connect(function()
	scriptHubFrame.Visible = false
	isScriptHubOpen = false
end)

--// Respawn button
scriptHubFrame:WaitForChild("Respawn").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "local a = game.Players:FindFirstChild('"..v.Name.."') if a then local lastPos = a.Character.HumanoidRootPart.CFrame a:LoadCharacter() a.Character:FindFirstChild('HumanoidRootPart').CFrame = lastPos end")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Convert to R6
scriptHubFrame:WaitForChild("R6").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..r6ConverterModule.."):Fire('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Dummy creator
scriptHubFrame:WaitForChild("DummyCreator").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..dummyCreatorModule..").createDummy('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Arch Angel
scriptHubFrame:WaitForChild("ArchAngel").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..archAngelModule.."):Fire('"..v.Name.."', 'test')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Ascend
scriptHubFrame:WaitForChild("Ascend").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..ascendModule..").ascend('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Raining ZeroTwo
scriptHubFrame:WaitForChild("RainingZeroTwo").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..rainingZeroTwoModule.."):Fire(nil, '"..v.Name.."', false)")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Raining ZeroTwo destructive
scriptHubFrame:WaitForChild("RainingZeroTwoDestructive").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..rainingZeroTwoModule.."):Fire(nil, '"..v.Name.."', true)")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// 123jl123's blimp (123jl123's stuff private uploaded module)
scriptHubFrame:WaitForChild("123jl123Blimp").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..private123jlStuffModule..").blimp('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Dodge (123jl123's stuff private uploaded module)
scriptHubFrame:WaitForChild("Dodge").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..private123jlStuffModule..").dodge('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Miku (123jl123's stuff private uploaded module)
scriptHubFrame:WaitForChild("Miku").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..private123jlStuffModule..").miku('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// The Sun is a Deadly Lazer
scriptHubFrame:WaitForChild("TheSunIsADeadlyLazer").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..theSunIsADeadlyLazerModule.."):Fire('"..v.Name.."', 'hack')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// Server Admin
scriptHubFrame:WaitForChild("ServerAdmin").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..serverAdminModule.."):Start('"..v.Name.."', 'AAA')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)

--// The BIG OwO
scriptHubFrame:WaitForChild("TheBigOwO").MouseButton1Click:Connect(function()
	local selectedPlr = utility.getPlayer(playerNameTextBox.Text)
	if selectedPlr then
		for _, v in pairs(selectedPlr) do
			local success, errorMsg = mainRemote:InvokeServer("executeCode", "require("..theBigOwOModule..").load('"..v.Name.."')")
			if not success then
				warn("[BloxExecutor_ScriptHub]: ScriptHub failed to execute script for:.."..v.Name..", error: "..errorMsg)
			end
		end
	end
end)


--// Initialize button
frame:WaitForChild("ScriptHub").MouseButton1Click:Connect(function()
	scriptHubFrame.Visible = true
	isScriptHubOpen = true
end)

wait(2)
actionText.Text = "Ready"
tweenService:Create(loadingFrame, TweenInfo.new(2), {Transparency = 1}):Play()
wait(2)
loadingFrame:Destroy()