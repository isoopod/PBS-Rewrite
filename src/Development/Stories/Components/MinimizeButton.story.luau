local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local MinimizeButton = require(ReplicatedStorage.PBSReplicated.UI.Components.MinimizeButton)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local UI_Labs = require(ServerStorage.Development.DevPackages.UI_Labs)

local story = UI_Labs.CreateReactStory({
	react = React,
	reactRoblox = ReactRoblox,
}, function(): any
	return React.createElement(MinimizeButton)
end)

return story
