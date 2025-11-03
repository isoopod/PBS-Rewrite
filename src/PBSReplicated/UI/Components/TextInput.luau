--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local GuiUtils = require(ReplicatedStorage.PBSReplicated.UI.GuiUtils)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type props = {
	initalText: string?,
	onTextChange: (string) -> ()?,
	maxLength: number?,
	containerNative: { [any]: any }?,
	textboxNative: { [any]: any }?,
	backgroundNative: { [any]: any }?,
}

return function(props: props)
	return e(
		"Frame",
		Dash.join({
			BackgroundTransparency = 1,
		}, props.containerNative or {}),
		{
			Input = e(GuiUtils.TextBox, {
				initialText = props.initalText,
				onTextChange = props.onTextChange,
				maxLength = props.maxLength,
				native = Dash.join({
					Size = UDim2.fromScale(1, 1),
					ZIndex = 2,
					BackgroundTransparency = 1,
					TextColor3 = Color3.new(1, 1, 1),
					TextSize = 10,
				}, props.textboxNative or {}),
			}),
			Background = e(
				"TextButton",
				Dash.join({
					Text = "",
					Style = Enum.ButtonStyle.RobloxButtonDefault,
					Size = UDim2.fromScale(1, 1),
				}, props.backgroundNative or {})
			),
		}
	)
end
