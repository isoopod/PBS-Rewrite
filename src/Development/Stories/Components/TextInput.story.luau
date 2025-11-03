local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local TextInput = require(ReplicatedStorage.PBSReplicated.UI.Components.TextInput)
local UI_Labs = require(ServerStorage.Development.DevPackages.UI_Labs)

local story = UI_Labs.CreateReactStory({
	react = React,
	reactRoblox = ReactRoblox,
}, function(): any
	local text, setText = React.useState("")

	return React.createElement(TextInput, {
		initalText = text,
		onTextChange = setText,
		maxLength = 100,
		containerNative = {
			Size = UDim2.fromOffset(200, 30),
		},
	})
end)

return story
