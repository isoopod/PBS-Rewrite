--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local ImageButton = require(script.Parent.ImageButton)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type props = ImageButton.props

return function(props: props?)
	return e(ImageButton, {
		buttonNative = Dash.join({
			Size = UDim2.fromOffset(34, 34),
		}, props and props.buttonNative or {}),
		imageNative = Dash.join({
			ImageContent = Content.fromAssetId(54932670),
			Size = UDim2.fromOffset(16, 20),
		}, props and props.imageNative or {}),
		children = props and props.children,
	})
end
