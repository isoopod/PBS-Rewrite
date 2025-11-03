--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
-- Modules
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type props = {
	color: Color3 | BrickColor,
}

return function(props: props) end
