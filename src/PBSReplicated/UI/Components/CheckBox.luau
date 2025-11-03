--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local React = require(ReplicatedStorage.Packages.React)
local ReactTypeHelpers = require(ReplicatedStorage.PBSReplicated.UI.ReactTypeHelpers)

local e = React.createElement

export type props = {
	toggled: boolean,
	setToggled: ReactTypeHelpers.StateSetter<boolean>,

	native: { [any]: any }?,
}

return function(props: props)
	return e(
		"TextButton",
		Dash.join({
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
