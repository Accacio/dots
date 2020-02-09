-----------------------------------------------------------------------------------------------------------------------
--                                   RedFlat pulseaudio volume control widget                                        --
-----------------------------------------------------------------------------------------------------------------------
-- Indicate and change volume level using pacmd
-----------------------------------------------------------------------------------------------------------------------
-- Some code was taken from
------ Pulseaudio volume control
------ https://github.com/orofarne/pulseaudio-awesome/blob/master/pulseaudio.lua
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
-----------------------------------------------------------------------------------------------------------------------
local math = math
local table = table
local tonumber = tonumber
local string = string
local setmetatable = setmetatable
local awful = require("awful")
local beautiful = require("beautiful")
local gears = require("gears")
local naughty = require("naughty")

local tooltip = require("redflat.float.tooltip")
local audio = require("redflat.gauge.audio.blue")
local rednotify = require("redflat.float.notify")
local redutil = require("redflat.util")


-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local pulse = { widgets = {}, mt = {} }
pulse.startup_time = 4

-- Generate default theme vars
-----------------------------------------------------------------------------------------------------------------------
local function default_style()
	local style = {
		notify      = {},
		widget      = audio.new,
		audio       = {}
	}
	return redutil.table.merge(style, redutil.table.check(beautiful, "widget.pulse") or {})
end

local change_volume_default_args = {
	down        = false,
	step        = math.floor(65536 / 100 * 5 + 0.5),
	show_notify = false
}

-- Support functions
-----------------------------------------------------------------------------------------------------------------------
local function get_default_sink(args)
	args = args or {}
	local type_ = args.type or "sink"

	local cmd = string.format("pacmd dump | grep 'set-default-%s'", type_)
	local output = redutil.read.output(cmd)
	local def_sink = string.match(output, "set%-default%-%w+%s(.+)\r?\n")

	return def_sink
end

-- Change volume level
-----------------------------------------------------------------------------------------------------------------------
function pulse:change_volume(args)

	-- initialize vars
	args = redutil.table.merge(change_volume_default_args, args or {})
	local diff = args.down and -args.step or args.step

	-- get current volume
	local v = redutil.read.output(string.format("pacmd dump | grep 'set-%s-volume %s'", self._type, self._sink))
	local parsed = string.match(v, "0x%x+")

	-- catch possible problems with pacmd output
	if not parsed then
		naughty.notify({ title = "Warning!", text = "PA widget can't parse pacmd output" })
		return
	end

	local volume = tonumber(parsed)

	-- calculate new volume
	local new_volume = volume + diff

	if new_volume > 65536 then
		new_volume = 65536
	elseif new_volume < 0 then
		new_volume = 0
	end

	-- show notify if need
	if args.show_notify then
		local vol = new_volume / 65536
		rednotify:show(
			redutil.table.merge({ value = vol, text = string.format('%.0f', vol*100) .. "%" }, self._style.notify)
		)
	end

	-- set new volume
	awful.spawn(string.format("pacmd set-%s-volume %s %s", self._type, self._sink, new_volume))

	-- update volume indicators
	self:update_volume()
end

-- Set mute
-----------------------------------------------------------------------------------------------------------------------
function pulse:mute(args)
	args = args or {}
	if not self._type or not self._sink then return end

	local mute = redutil.read.output(string.format("pacmd dump | grep 'set-%s-mute %s'", self._type, self._sink))

	if string.find(mute, "no", -4) then
		awful.spawn(string.format("pacmd set-%s-mute %s yes", self._type, self._sink))
	else
		awful.spawn(string.format("pacmd set-%s-mute %s no", self._type, self._sink))
	end

	self:update_volume()
end

-- Update volume level info
-----------------------------------------------------------------------------------------------------------------------
function pulse:update_volume(args)
	args = args or {}
	if not self._type or not self._sink then return end

	-- initialize vars
	local volmax = 65536
	local volume = 0

	-- get current volume and mute state
	local v = redutil.read.output(string.format("pacmd dump | grep 'set-%s-volume %s'", self._type, self._sink))
	local m = redutil.read.output(string.format("pacmd dump | grep 'set-%s-mute %s'", self._type, self._sink))

	if v then
		local pv = string.match(v, "0x%x+")
		if pv then volume = math.floor(tonumber(pv) * 100 / volmax + 0.5) end
	end

	local mute = not (m and string.find(m, "no", -4))

	-- update widgets value
	self:set_value(volume / 100)
	self:set_mute(mute)
	self._tooltip:set_text(volume .. "%")
end

-- Create a new pulse widget
-- @param timeout Update interval
-----------------------------------------------------------------------------------------------------------------------
function pulse.new(args, style)

	-- Initialize vars
	--------------------------------------------------------------------------------
	style = redutil.table.merge(default_style(), style or {})

	args = args or {}
	local timeout = args.timeout or 5
	local autoupdate = args.autoupdate or false

	-- create widget
	--------------------------------------------------------------------------------
	local widg = style.widget(style.audio)
	gears.table.crush(widg, pulse, true) -- dangerous since widget have own methods, but let it be by now

	widg._type = args.type or "sink"
	widg._sink = args.sink
	widg._style = style

	table.insert(pulse.widgets, widg)

	-- Set tooltip
	--------------------------------------------------------------------------------
	widg._tooltip = tooltip({ objects = { widg } }, style.tooltip)

	-- Set update timer
	--------------------------------------------------------------------------------
	if autoupdate then
		local t = gears.timer({ timeout = timeout })
		t:connect_signal("timeout", function() widg:update_volume() end)
		t:start()
	end

	-- Set startup timer
	-- This is workaround if module activated bofore pulseaudio servise start
	--------------------------------------------------------------------------------
	if not widg._sink then
		local st = gears.timer({ timeout = 1 })
		local counter = 0
		st:connect_signal("timeout", function()
			counter = counter + 1
			widg._sink = get_default_sink({ type = widg._type })
			if widg._sink then widg:update_volume() end
			if counter > pulse.startup_time or widg._sink then st:stop() end
		end)
		st:start()
	else
		widg:update_volume()
	end

	--------------------------------------------------------------------------------
	return widg
end

-- Config metatable to call pulse module as function
-----------------------------------------------------------------------------------------------------------------------
function pulse.mt:__call(...)
	return pulse.new(...)
end

return setmetatable(pulse, pulse.mt)