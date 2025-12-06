local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CheckBox = require(ReplicatedStorage.PBSReplicated.UI.Components.CheckBox)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local UI_Labs = require(ReplicatedStorage.Packages.UI_Labs)

local story = UI_Labs.CreateReactStory({
	react = React,
	reactRoblox = ReactRoblox,
}, function(): any
	local toggled, setToggled = React.useState(false)

	return React.createElement(CheckBox, {
		toggled = toggled,
		setToggled = setToggled,
		native = {
			Size = UDim2.fromOffset(20, 20),
		},
	})
end)

return story
