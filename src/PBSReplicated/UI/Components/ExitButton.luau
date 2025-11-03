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
		buttonNative = props and props.buttonNative,
		imageNative = Dash.join({
			ImageContent = Content.fromAssetId(54135717),
			Size = UDim2.fromScale(1.4, 1.4),
		}, props and props.imageNative or {}),
		children = props and props.children,
	})
end
