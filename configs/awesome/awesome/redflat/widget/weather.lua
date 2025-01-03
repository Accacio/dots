-----------------------------------------------------------------------------------------------------------------------
--                                               RedFlat clock widget                                                --
-----------------------------------------------------------------------------------------------------------------------
-- Text clock widget with date in tooltip (optional)
-----------------------------------------------------------------------------------------------------------------------
-- Some code was taken from
------ awful.widget.textclock v3.5.2
------ (c) 2009 Julien Danjou
-----------------------------------------------------------------------------------------------------------------------

local setmetatable = setmetatable
local os = os
local textbox = require("wibox.widget.textbox")
local beautiful = require("beautiful")
local gears = require("gears")

local tooltip = require("redflat.float.tooltip")
local redutil = require("redflat.util")
-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local textclock = { mt = {} }

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		font  = "Sans 12",
		tooltip = {},
		color = { text = "#aaaaaa" }
	}
	return redutil.table.merge(style, redutil.table.check(beautiful, "widget.textclock") or {})
end

-- Create a textclock widget. It draws the time it is in a textbox.
-- @param format The time format. Default is " %a %b %d, %H:%M ".
-- @param timeout How often update the time. Default is 60.
-- @return A textbox widget
-----------------------------------------------------------------------------------------------------------------------
function textclock.new(args, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	args = args or {}
	local timeformat = args.timeformat or " %a %b %d, %H:%M "
	local timeout = args.timeout or 60
	style = redutil.table.merge(default_style(), style or {})

	-- Create widget
	--------------------------------------------------------------------------------
	local widg = textbox()
	widg:set_font(style.font)

	-- Set tooltip if need
	--------------------------------------------------------------------------------
	local tp
	if args.dateformat then tp = tooltip({ objects = { widg } }, style.tooltip) end

	-- Set update timer
	--------------------------------------------------------------------------------
	local timer = gears.timer({ timeout = timeout })
	timer:connect_signal("timeout",
		function()
			local handle = io.popen("curl -s wttr.in/Nantes -m 1  | tr -dc '[[:print:][:space:]]' | sed 's,\\[\\([0-9]*;\\)*[0-9]*m,,g' | tac | sed 1d | tac ")
			local result = handle:read("*a")
			local umiHandle = io.popen("curl -s wttr.in -m 1 | sed '16q;d'  | grep -wo '[0-9]*%' | sort -rn | sed 's,^,🌧\\ ,g;1q' | tr -d '\\n'")
			local umiResult = umiHandle:read("*a")

			widg:set_markup('<span color="' .. style.color.text .. '">' .. umiResult .. "</span>")
			if args.dateformat then tp:set_text(result) end
		end)
	timer:start()
	timer:emit_signal("timeout")

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call textclock module as function
-----------------------------------------------------------------------------------------------------------------------
function textclock.mt:__call(...)
	return textclock.new(...)
end

return setmetatable(textclock, textclock.mt)
