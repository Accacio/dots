-----------------------------------------------------------------------------------------------------------------------
--                                                Rules config                                                       --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful =require("awful")
local beautiful = require("beautiful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local rules = {}

rules.base_properties = {
	border_width = beautiful.border_width,
	border_color = beautiful.border_normal,
	focus        = awful.client.focus.filter,
	raise        = true,
	size_hints_honor = false,
	screen       = awful.screen.preferred,
	placement    = awful.placement.no_overlap + awful.placement.no_offscreen
}

rules.floating_any = {
	instance = { "DTA", "copyq", },
	class = {
		"Arandr", "Gpick", "Kruler", "MessageWin", "Sxiv", "wpp", "Wpa_gui", "pinentry", "mail", "veromix",
		"xtightvncviewer"
	},
	name = { "Event Tester", "WhatsApp" },
	role = { "AlarmWindow", "pop-up", }
}


-- Build rule table
-----------------------------------------------------------------------------------------------------------------------
function rules:init(args)

	args = args or {}
	self.base_properties.keys = args.hotkeys.keys.client
	self.base_properties.buttons = args.hotkeys.mouse.client


	-- Build rules
	--------------------------------------------------------------------------------
	self.rules = {
		{
			rule       = {},
			properties = args.base_properties or self.base_properties
		},
		{
			rule_any   = args.floating_any or self.floating_any,
			properties = { floating = true }
		},
		{
			rule  = { },
			properties = { maximized = false}
		},
		{
			rule_any   = { class = {"wpp"}},
			properties = { floating = true, ontop=true , sticky=true,maximized = false}
		},
		{
			rule_any   = { class = {"vimb"},name={"WhatsApp","http://web.whatsapp.com/"}},
			properties = { floating = true, ontop=true , sticky=true}
		},
		{
			rule_any   = { class = {"mpv"}},
			properties = { floating = true, ontop=true , sticky=true}
		},
		{
			rule_any   = { type = { "normal", "dialog" }},
			properties = { titlebars_enabled = false}
		},
	}


	-- Set rules
	--------------------------------------------------------------------------------
	awful.rules.rules = rules.rules
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return rules
