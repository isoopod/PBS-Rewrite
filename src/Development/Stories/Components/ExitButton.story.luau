local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ExitButton = require(ReplicatedStorage.PBSReplicated.UI.Components.ExitButton)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local UI_Labs = require(ReplicatedStorage.Packages.UI_Labs)

local story = UI_Labs.CreateReactStory({
	react = React,
	reactRoblox = ReactRoblox,
}, function(): any
	return React.createElement(ExitButton)
end)

return story
