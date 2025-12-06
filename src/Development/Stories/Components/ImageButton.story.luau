local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ImageButton = require(ReplicatedStorage.PBSReplicated.UI.Components.ImageButton)
local React = require(ReplicatedStorage.Packages.React)
local ReactRoblox = require(ReplicatedStorage.Packages.ReactRoblox)
local UI_Labs = require(ReplicatedStorage.Packages.UI_Labs)

local story = UI_Labs.CreateReactStory({
	react = React,
	reactRoblox = ReactRoblox,
}, function(): any
	return React.createElement(ImageButton, {
		buttonNative = {
			Size = UDim2.fromOffset(34, 34),
		},
		imageNative = {
			ImageContent = Content.fromAssetId(54932670),
			Size = UDim2.fromOffset(16, 20),
		},
	})
end)

return story
