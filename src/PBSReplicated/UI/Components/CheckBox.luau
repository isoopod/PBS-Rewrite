--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local GuiUtils = require(ReplicatedStorage.PBSReplicated.UI.GuiUtils)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type props = {
	toggled: boolean,
	setToggled: GuiUtils.StateSetter<boolean>,

	native: { [any]: any }?,
}

return function(props: props)
	return e(
		"TextButton",
		Dash.join({
			Size = UDim2.fromScale(20, 20),
			Style = Enum.ButtonStyle.RobloxButtonDefault,
			TextColor3 = Color3.new(1, 1, 1),
			TextSize = 14,
			Text = props.toggled and "X" or "",
			[React.Event.Activated] = function()
				props.setToggled(not props.toggled)
			end,
		}, props.native or {})
	)
end
