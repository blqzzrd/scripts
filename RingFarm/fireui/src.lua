local _version = "1.6.64-fix"
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/download/" .. _version .. "/main.lua"))()

-- local WindUI = require(script.WindUI)

WindUI:SetNotificationLower(true)
WindUI:SetTheme("Dark")

--[[ 
	Script Functions
------------------------
]]--

local function getPlot()
	for _, i in ipairs(workspace.Map.Plots:GetChildren()) do
		local text = i.OwnerSign.Face.SurfaceGui.TextLabel.Text
		if text == game.Players.LocalPlayer.Name or text == game.Players.LocalPlayer.DisplayName then
			return i.Name
		end
	end
end
local plot = getPlot()

local function UnlockPlots(floor, row)
	local plotFolder = workspace.Map.Plots[plot]
	local plotObj
	if floor == "1" then
		plotObj = plotFolder.FarmPlot["Plot" .. row]
	else
		plotObj = plotFolder["Floor" .. floor].FarmPlot["Plot" .. row]
	end
	for _, farms in ipairs(plotObj.Parent:GetChildren()) do
		if farms.Name == "Plot" .. row then
			local dirt = farms:FindFirstChild("Dirt")
			game.ReplicatedStorage.Remotes.UnlockPlot:FireServer(dirt)
			task.wait(0.2)
		end
	end
end

local function PlantSeed(floor, row)
	local plotFolder = workspace.Map.Plots[plot]
	local plotObj
	if floor == "1" then
		plotObj = plotFolder.FarmPlot["Plot" .. row]
	else
		plotObj = potFolder["Floor" .. floor].FarmPlot["Plot" .. row]
	end
	for _, farms in ipairs(plotObj.Parent:GetChildren()) do
		if farms.Name == "Plot" .. row then
			local dirt = farms:FindFirstChild("Dirt")
			game.ReplicatedStorage.Remotes.PlantSeed:FireServer(dirt)
			task.wait(0.2)
		end
	end
end

local function SellCrates()
	game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("SellCrates"):FireServer()
end

--[[ 
		 Menu
------------------------
]]--


local Window = WindUI:CreateWindow({
	Title = "fire ui",
	Icon = "banana",
	Author = "yo mama",
})
local Manual = Window:Tab({
	Title = "Manual",
	Icon = "anchor",
})
local FloorDropdown = Manual:Dropdown({
	Title = "Select Floor",
	Values = {
		"Floor 1",
		"Floor 2",
		"Floor 3"
	}
})
local values
if FloorDropdown.Value == "Floor 1" then
	values = {
		"Saw Range",
		"Sprinker Range",
		"Saw Yield",
		"Sprinkler Power",
		"Unlock Plots",
		"Seed Luck",
		"Seed Rolls",
		"Expand Farm"
	}
else
	values = {
		"Saw Range",
		"Sprinker Range",
		"Saw Yield",
		"Sprinkler Power",
		"Unlock Plots"
	}
end
local UpgradesDropdown = Manual:Dropdown({
	Title = "Select Upgrade",
	Values = values
})

local Settings = Window:Tab({
	Title = "Settings",
	Icon = "settings",
})
local ThemesSection = Settings:Section({
	Title = "Themes",
	Icon = "paintbrush",
})
local ThemesList = ThemesSection:Dropdown({
	Title = "Select Theme",
	Values = {
		"Dark",
		"Light",
		"Rose",
		"Plant",
		"Red",
		"Indigo",
		"Sky",
		"Violet",
		"Amber",
		"Emerald",
		"Midnight",
		"Crimson",
		"Monokai Pro",
		"Cotton Candy",
		"Mellowsi",
		"Rainbow"
	},
	Callback = function(selected)
		WindUI:SetTheme(selected)
	end
})
ThemesList:Select("Dark")
