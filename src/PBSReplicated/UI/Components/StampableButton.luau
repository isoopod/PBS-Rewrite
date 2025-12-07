--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type props = {
	buttonNative: { [any]: any }?,
	imageNative: { [any]: any }?,
	children: React.ReactNode?,
}

return function(props: props)
	return e(
		"TextButton",
		Dash.join({
			Size = UDim2.fromOffset(32, 32),
			Style = Enum.ButtonStyle.RobloxButtonDefault,
			Text = "",
		}, props.buttonNative or {}),
		{
			Label = e(
				"ImageLabel",
				Dash.join({
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
				}, props.imageNative or {})
			),
		},
		props.children
	)
end
