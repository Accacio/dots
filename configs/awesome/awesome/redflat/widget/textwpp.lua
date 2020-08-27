
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
	local timeout = args.timeout or 10
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
                           local handle =
                             io.popen('xprop -id `xdotool search --classname "wpp"|tail -n 1|head -n 1`| grep -i "wm_name(string)" | sed -E "s,^.*\\"(\\(|)([0-9]+|)(\\) |).*\\",\\2,"')
                           -- local handle = io.popen("xprop -id `xdotool search --classname \"wpp\"|tail -n 1|head -n 1` | grep -i \"wm_name(string)\" | sed -E \"s<^.*\"(\(|)([0-9]+|)(\)|).*\"$<\2<\"")
                           local result = handle:read("*a")
                           handle:close()
                           widg:set_markup('<span color="' .. style.color.text .. '">'
                                             .. "Wpp: " .. result .. "</span>")
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
