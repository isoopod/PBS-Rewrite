--!strict

-- Services
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
-- Modules
local Dash = require(ReplicatedStorage.Packages.Dash)
local React = require(ReplicatedStorage.Packages.React)

local e = React.createElement

export type StateSetter<T> = (((T) -> T) | T) -> ()

local utils = {}

--[[
    Creates a new ordering function for layout order in lists

    Usage:
        local nextOrder = GuiUtils.createNextOrder()

        (create list and sub elements)
        ...
            LayoutOrder = nextOrder(),
        ...
            LayoutOrder = nextOrder(),
]]
function utils.createNextOrder(): () -> number
	local layoutOrder = 0

	return function()
		layoutOrder += 1
		return layoutOrder
	end
end

-- If you ever want to use an indice in a React name, use this instead.
function utils.createUniqueKey(): (string) -> string
	local names = {}

	return function(name)
		if names[name] == nil then
			names[name] = 1
			return name
		else
			-- Edge case in case of:
			-- uniqueKey("foo") -- foo
			-- uniqueKey("foo_2") -- foo_2
			-- uniqueKey("foo") -- foo_2 (clash)
			while true do
				names[name] += 1
				local finalName = `{name}_{names[name]}`

				if names[finalName] == nil then return finalName end
			end
		end
	end
end

function utils.useToggleState(default: boolean): {
	on: boolean,
	enable: () -> (),
	disable: () -> (),
	toggle: () -> (),
}
	local toggled, setToggled = React.useState(default)

	local enable = React.useCallback(function()
		setToggled(true)
	end, {})

	local disable = React.useCallback(function()
		setToggled(false)
	end, {})

	local toggle = React.useCallback(function()
		setToggled(function(currentToggled)
			return not currentToggled
		end)
	end, {})

	return {
		on = toggled,
		enable = enable,
		disable = disable,
		toggle = toggle,
	}
end

--[[
    Returns a binding to get the amount of time since the component was mounted.

    Can be used with TweenService:GetValue as an alternative to ReactSpring for animation
]]
function utils.useClock(start: number?): React.Binding<number>
	local clockBinding, setClockBinding = React.useBinding(start or 0)

	React.useEffect(function()
		local stepConnection = RunService.PostSimulation:Connect(function(delta)
			setClockBinding(clockBinding:getValue() + delta)
		end)

		return function()
			stepConnection:Disconnect()
		end
	end, {})

	return clockBinding
end

-- Very simple one for hooking onto an event and disconnecting from it later
function utils.useEventConnection<T...>(
	event: RBXScriptSignal<T...>, -- Can also include | Signal.Signal<T...> if you're using a custom signal type
	callback: (T...) -> (),
	dependencies: { any }
)
	local cachedCallback = React.useMemo(function()
		return callback
	end, dependencies)

	React.useEffect(function()
		local connection = event:Connect(cachedCallback)

		return function()
			connection:Disconnect()
		end
	end, { event, cachedCallback } :: { unknown })
end

function utils.TextBox(props: {
	initialText: string?,
	onTextChange: (string) -> ()?,
	maxLength: number?,

	native: { [string]: any }?,
	children: React.ReactNode?,
})
	-- Ref instead of binding/state to allow Roblox's normal updating without re-renders,
	-- which are noticably clunky on mobile.
	local currentTextRef = React.useRef(props.initialText)

	React.useEffect(function()
		currentTextRef.current = props.initialText
	end, { props.initialText })

	local onTextChange = React.useCallback(function(textBox: TextBox)
		local text = textBox.Text

		if text == currentTextRef.current then return end

		if props.maxLength and #text > props.maxLength then
			textBox.Text = string.sub(text, 1, props.maxLength)
			return
		end

		currentTextRef.current = text

		if props.onTextChange ~= nil then props.onTextChange(text) end
	end, { props.onTextChange, props.maxLength or 0 } :: { unknown })

	return e(
		"TextBox",
		Dash.join({
			Text = props.initialText or "",

			[React.Change.Text] = onTextChange,
		}, props.native or {}),
		props.children
	)
end

return utils
