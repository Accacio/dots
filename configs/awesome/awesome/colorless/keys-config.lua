-----------------------------------------------------------------------------------------------------------------------
--                                          Hotkeys and mouse buttons config                                         --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")
local naughty = require("naughty")
local redflat = require("redflat")
local beautiful = require("beautiful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local hotkeys = { mouse = {}, raw = {}, keys = {}, fake = {} }

-- key aliases
local apprunner = redflat.float.apprunner
local appswitcher = redflat.float.appswitcher
local current = redflat.widget.tasklist.filter.currenttags
local allscr = redflat.widget.tasklist.filter.allscreen
local laybox = redflat.widget.layoutbox
local redtip = redflat.float.hotkeys
-- local redtitle = redflat.titlebar

-- Key support functions
-----------------------------------------------------------------------------------------------------------------------
local focus_switch_byd = function(dir)
	return function()
		awful.client.focus.bydirection(dir)
		awful.spawn('bash -c "sleep 0.1;xdotool mousemove --window $(xdotool getwindowfocus) --polar 0 0"')
		if client.focus then client.focus:raise() end
	end
end
local swap_switch_byd = function(dir)
	return function()
		awful.client.swap.bydirection(dir)
		awful.spawn('bash -c "sleep 0.1;xdotool mousemove --window $(xdotool getwindowfocus) --polar 0 0"')
		if client.focus then client.focus:raise() end
	end
end

local move_screen_switch_byd = function(dir)
	return function()
		local c = client.focus
		-- awful.client.move_to_screen()
		-- awful.spawn('bash -c "sleep 0.1;xdotool mousemove --window $(xdotool getwindowfocus) --polar 0 0"')
		if client.focus then client.focus:raise() end
	end
end

local function minimize_all()
	for _, c in ipairs(client.get()) do
		if current(c, mouse.screen) then c.minimized = true end
	end
end

local function minimize_all_except_focused()
	for _, c in ipairs(client.get()) do
		if current(c, mouse.screen) and c ~= client.focus then c.minimized = true end
	end
end

local function restore_all()
	for _, c in ipairs(client.get()) do
		if current(c, mouse.screen) and c.minimized then c.minimized = false end
	end
end

local function kill_all()
	for _, c in ipairs(client.get()) do
		if current(c, mouse.screen) and not c.sticky then c:kill() end
	end
end

local function focus_to_previous()
	awful.client.focus.history.previous()
	if client.focus then client.focus:raise() end
end

local function restore_client()
	local c = awful.client.restore()
	if c then client.focus = c; c:raise() end
end

local function toggle_placement(env)
	env.set_slave = not env.set_slave
	redflat.float.notify:show({ text = (env.set_slave and "Slave" or "Master") .. " placement" })
end

local function tag_numkey(i, mod, action)
	return awful.key(
		mod, "#" .. i + 9,
		function ()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
			if tag then action(tag) end
		end
	)
end

local function client_numkey(i, mod, action)
	return awful.key(
		mod, "#" .. i + 9,
		function ()
			if client.focus then
				local tag = client.focus.screen.tags[i]
				if tag then action(tag) end
			end
		end
	)
end


-- Build hotkeys depended on config parameters
-----------------------------------------------------------------------------------------------------------------------
function hotkeys:init(args)

	-- Init vars
	------------------------------------------------------------
	args = args or {}
	local env = args.env
	local mainmenu = args.menu

	self.mouse.root = (awful.util.table.join(
		awful.button({ }, 3, function () mainmenu:toggle() end),
		awful.button({ }, 4, awful.tag.viewnext),
		awful.button({ }, 5, awful.tag.viewprev),
		awful.button({ }, 22, function () awful.spawn("wacomChangeOutput 1") end),
		awful.button({ }, 23, function () awful.spawn("wacomChangeOutput 2") end)
	))

	-- Layouts
	--------------------------------------------------------------------------------
	-- this is example for layouts hotkeys setup, see other color configs for more

	-- local layout_tile = {
	-- 	{
	-- 		{ env.mod }, "l", function () awful.tag.incmwfact( 0.05) end,
	-- 		{ description = "Increase master width factor", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod }, "j", function () awful.tag.incmwfact(-0.05) end,
	-- 		{ description = "Decrease master width factor", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod }, "i", function () awful.client.incwfact( 0.05) end,
	-- 		{ description = "Increase window factor of a client", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod }, "k", function () awful.client.incwfact(-0.05) end,
	-- 		{ description = "Decrease window factor of a client", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod, }, "+", function () awful.tag.incnmaster( 1, nil, true) end,
	-- 		{ description = "Increase the number of master clients", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod }, "-", function () awful.tag.incnmaster(-1, nil, true) end,
	-- 		{ description = "Decrease the number of master clients", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod, "Control" }, "+", function () awful.tag.incncol( 1, nil, true) end,
	-- 		{ description = "Increase the number of columns", group = "Layout" }
	-- 	},
	-- 	{
	-- 		{ env.mod, "Control" }, "-", function () awful.tag.incncol(-1, nil, true) end,
	-- 		{ description = "Decrease the number of columns", group = "Layout" }
	-- 	},
	-- }

	-- laycom:set_keys(layout_tile, "tile")

	-- Keys for widgets
	--------------------------------------------------------------------------------

	-- Apprunner widget
	------------------------------------------------------------
	local apprunner_keys_move = {

		{
			{ "Control"  }, "n", function() apprunner:down() end,
			{ description = "Select next item", group = "Navigation" }
		},
		{
			{ "Control"  }, "p", function() apprunner:up() end,
			{ description = "Select previous item", group = "Navigation" }
		},
		{
			{ "Control" }, "j", function() apprunner:down() end,
			{ description = "Select next item", group = "Navigation" }
		},
		{
			{ "Control" }, "k", function() apprunner:up() end,
			{ description = "Select previous item", group = "Navigation" }
		},
	}

	apprunner:set_keys(awful.util.table.join(apprunner.keys.move, apprunner_keys_move), "move")

	-- Menu widget
	------------------------------------------------------------
	local menu_keys_move = {
		{
			{ env.mod }, "k", redflat.menu.action.down,
			{ description = "Select next item", group = "Navigation" }
		},
		{
			{ env.mod }, "i", redflat.menu.action.up,
			{ description = "Select previous item", group = "Navigation" }
		},
		{
			{ env.mod }, "j", redflat.menu.action.back,
			{ description = "Go back", group = "Navigation" }
		},
		{
			{ env.mod }, "l", redflat.menu.action.enter,
			{ description = "Open submenu", group = "Navigation" }
		},
	}

	redflat.menu:set_keys(awful.util.table.join(redflat.menu.keys.move, menu_keys_move), "move")

	-- Appswitcher
	------------------------------------------------------------
	local appswitcher_keys_move = {
		{
			{ env.mod }, "a", function() appswitcher:switch() end,
			{ description = "Select next app", group = "Navigation" }
		},
		{
			{ env.mod }, "q", function() appswitcher:switch({ reverse = true }) end,
			{ description = "Select previous app", group = "Navigation" }
		},
	}

	local appswitcher_keys_action = {
		{
			{ env.mod }, "Super_L", function() appswitcher:hide() end,
			{ description = "Activate and exit", group = "Action" }
		},
		{
			{}, "Escape", function() appswitcher:hide(true) end,
			{ description = "Exit", group = "Action" }
		},
	}

	appswitcher:set_keys(awful.util.table.join(appswitcher.keys.move, appswitcher_keys_move), "move")
	appswitcher:set_keys(awful.util.table.join(appswitcher.keys.action, appswitcher_keys_action), "action")


	-- Emacs like key sequences
	--------------------------------------------------------------------------------

	-- initial key
	-- first prefix key, no description needed here
	local keyseq = { { env.mod }, "c", {}, {} }

	-- second sequence keys
	keyseq[3] = {
		-- second and last key in sequence, full description and action is necessary
		{
			{}, "p", function () toggle_placement(env) end,
			{ description = "Switch master/slave window placement", group = "Clients managment" }
		},

		-- not last key in sequence, no description needed here
		{ {}, "k", {}, {} }, -- application kill group
		{ {}, "n", {}, {} }, -- application minimize group
		{ {}, "r", {}, {} }, -- application restore group

		-- { {}, "g", {}, {} }, -- run or rise group
		-- { {}, "f", {}, {} }, -- launch application group
	}

	-- application kill actions,
	-- last key in sequence, full description and action is necessary
	keyseq[3][2][3] = {
		{
			{}, "f", function() if client.focus then client.focus:kill() end end,
			{ description = "Kill focused client", group = "Kill application", keyset = { "f" } }
		},
		{
			{}, "a", kill_all,
			{ description = "Kill all clients with current tag", group = "Kill application", keyset = { "a" } }
		},
	}

	-- application minimize actions,
	-- last key in sequence, full description and action is necessary
	keyseq[3][3][3] = {
		{
			{}, "f", function() if client.focus then client.focus.minimized = true end end,
			{ description = "Minimized focused client", group = "Clients managment", keyset = { "f" } }
		},
		{
			{}, "a", minimize_all,
			{ description = "Minimized all clients with current tag", group = "Clients managment", keyset = { "a" } }
		},
		{
			{}, "e", minimize_all_except_focused,
			{ description = "Minimized all clients except focused", group = "Clients managment", keyset = { "e" } }
		},
	}

	-- application restore actions,
	-- last key in sequence, full description and action is necessary
	keyseq[3][4][3] = {
		{
			{}, "f", restore_client,
			{ description = "Restore minimized client", group = "Clients managment", keyset = { "f" } }
		},
		{
			{}, "a", restore_all,
			{ description = "Restore all clients with current tag", group = "Clients managment", keyset = { "a" } }
		},
	}

	-- quick launch key sequence actions, auto fill up last sequence key
	-- for i = 1, 9 do
	-- 	local ik = tostring(i)
	-- 	table.insert(keyseq[3][5][3], {
	-- 		{}, ik, function() qlaunch:run_or_raise(ik) end,
	-- 		{ description = "Run or rise application №" .. ik, group = "Run or Rise", keyset = { ik } }
	-- 	})
	-- 	table.insert(keyseq[3][6][3], {
	-- 		{}, ik, function() qlaunch:run_or_raise(ik, true) end,
	-- 		{ description = "Launch application №".. ik, group = "Quick Launch", keyset = { ik } }
	-- 	})
	-- end


	-- Global keys
	--------------------------------------------------------------------------------
	self.raw.root = {
		-- 	tag_numkey(i,    { env.mod, "Control" },          function(t) awful.tag.viewtoggle(t)     end),
		-- 	client_numkey(i, { env.mod, "Shift" },            function(t) client.focus:move_to_tag(t) end),
		-- 	client_numkey(i, { env.mod, "Control", "Shift" }, function(t) client.focus:toggle_tag(t)  end)
-- TODO find selected tag
		{
			{ env.mod , "Control", "Shift"}, "#19",
			function()
			local screen = awful.screen.focused()
			local tag = screen.tags[i]
				local tags = screen.tags
				for i,tag in ipairs(tags)
				do
					if tag ~= awful.tag.selected()
					then
						client.focus:toggle_tag(screen.tags[i])
					end
				end
			end,
			{ }
		},
		{
			{ "Control" }, "F3", function() awful.util.spawn("macroRecord") end,
			{ description = "", group = "Main" }
		},
		{
			{ "Control" }, "F4", function() awful.util.spawn("macroStopPlay") end,
			{ description = "", group = "Main" }
		},
		{
			{ }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot -s '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && rm $f'") end,
			{ description = "ScreenShot Area clipboard", group = "Screenshot" }
		},
		{
			{ "Shift" }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot -s '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && mv $f ~/Downloads/lixo/'") end,
			{ description = "ScreenShot Area disk", group = "Screenshot" }
		},
		{
			{ env.mod }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot  '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && rm $f'") end,
			{ description = "ScreenShot Desktop clipboard", group = "Screenshot" }
		},
		{
			{ env.mod , "Shift" }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && mv $f ~/Downloads/lixo/'") end,
			{ description = "ScreenShot Desktop disk", group = "Screenshot" }
		},
		{
			{ "Control" }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot -u '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && rm $f'") end,
			{ description = "ScreenShot Window clipboard", group = "Screenshot" }
		},
		{
			{ "Control", "Shift" }, "Print", function() awful.util.spawn_with_shell("sleep 0.5;scrot -u '%Y%m%d_%H%M_$wx$h.png' -e 'xclip -selection c -t image/png $f && mv $f ~/Downloads/lixo/'") end,
			{ description = "ScreenShot Window save", group = "Screenshot" }
		},
		{
			{ }, "XF86AudioMute", function() awful.spawn("pactl set-sink-mute @DEFAULT_SINK@ toggle") end,
			{ description = "Mute", group = "Audio" }
		},
		{
			{"Control", "Shift" }, "Escape", function() awful.util.spawn_with_shell(env.terminal .. " -t htop --class htop -o window.dimensions.columns=160 -o window.dimensions.lines=30 -e htop") end,
			{ description = "open Htop", group = "MGMT" }
		},
		{
			-- {env.mod, "Shift" }, "c", function() awful.util.spawn_with_shell("VISUAL='emacsclient -s $HOME/.emacs.d/server/server -tc -a \"emacs -nw\" ';" .. env.terminal .. " -t calendar --class calendar -o window.dimensions.columns=160 -o window.dimensions.lines=30 -e ikhal") end,
			{env.mod, "Shift" }, "c", function() awful.util.spawn_with_shell("VISUAL='emacsclient -tc -a \"emacs -nw\" ';" .. env.terminal .. " -t calendar --class calendar -o window.dimensions.columns=160 -o window.dimensions.lines=30 -e ~/.local/bin/ikhal") end,
			{ description = "open calendar", group = "Calendar" }
		},
		{
			-- {env.mod, "Shift" }, "m", function() awful.util.spawn_with_shell("VISUAL='emacsclient -s $HOME/.emacs.d/server/server -tc -a \"emacs -nw\" ';" .. env.terminal .. " -t mail --class mail -o window.dimensions.columns=160 -o window.dimensions.lines=30 -e neomutt") end,
			{env.mod, "Shift" }, "m", function() awful.util.spawn_with_shell("VISUAL='emacsclient -tc -a \"emacs -nw\" ';" .. env.terminal .. " -t mail --class mail -o window.dimensions.columns=160 -o window.dimensions.lines=30 -e neomutt") end,
			{ description = "open Mail", group = "Mail" }
		},
		{
			{env.mod, "Ctrl" }, "F11", function() awful.util.spawn_with_shell(env.terminal .. " --class music  -o window.dimensions.columns=160 -o window.dimensions.lines=30 -t ncmpcpp -e ncmpcpp") end,
			{ description = "Open ncmpcpp", group = "Audio" }
		},
		{
			{env.mod, "Shift" }, "XF86AudioPlay", function() awful.util.spawn_with_shell(env.terminal .. " --class music  -o window.dimensions.columns=160 -o window.dimensions.lines=30 -t ncmpcpp -e ncmpcpp") end,
			{ description = "Open ncmpcpp", group = "Audio" }
		},
		{
			{env.mod,"Shift"}, "F11", function() awful.util.spawn_with_shell("mpdMenuImage $HOME/Music") end,
			{ description = "Select what to play", group = "Audio" }
		},
		{
			{env.mod }, "XF86AudioPlay", function() awful.util.spawn_with_shell("mpdMenuImage $HOME/Music") end,
			{ description = "Select what to play", group = "Audio" }
		},
		{
			{env.mod }, "F11", function() awful.util.spawn_with_shell("mpc toggle; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Play/Pause", group = "Audio" }
		},
		{
			{ }, "XF86AudioPlay", function() awful.util.spawn_with_shell("mpc toggle; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Play/Pause", group = "Audio" }
		},
		{
			{ env.mod }, "F10", function() awful.util.spawn_with_shell("mpc prev; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Previous", group = "Audio" }
		},
		{
			{ }, "XF86AudioPrev", function() awful.util.spawn_with_shell("mpc prev; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Previous", group = "Audio" }
		},
		{
			{ env.mod }, "F12", function() awful.util.spawn_with_shell("mpc next; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Next", group = "Audio" }
		},
		{
			{ }, "XF86AudioNext", function() awful.util.spawn_with_shell("mpc next; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Next", group = "Audio" }
		},
		{
			{ }, "XF86AudioStop", function() awful.util.spawn_with_shell("mpc stop; $SCRIPTSFOLDER/musicNotify") end,
			{ description = "Stop", group = "Audio" }
		},
		{
			{ }, "XF86Display", function() awful.util.spawn_with_shell("$SCRIPTSFOLDER/multimonitor") end,
			{ description = "Monitors", group = "Audio" }
		},
		{
			{ }, "XF86AudioLowerVolume", function() awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ -5%") end,
			{ description = "Lower Volume", group = "Audio" }
		},
		{
			{ }, "XF86AudioRaiseVolume", function() awful.spawn("pactl set-sink-volume @DEFAULT_SINK@ +5%") end,
			{ description = "Raise Volume", group = "Audio" }
		},
		{
			{ env.mod , "Control"}, "#19",
			function()
				local screen = awful.screen.focused()
				local tag = screen.tags[i]
				local current = client.focus and client.focus.first_tag or screen.selected_tag or nil
				local tags = screen.tags
				for i,tag in ipairs(tags)
				do
					if tag ~= current
					then
						awful.tag.viewtoggle(screen.tags[i])
					end
				end
			end,
			{ }
		},
		-- {
		-- 	{ env.mod }, "#19", function() redtip:show() end,
		-- 	{ description = "Show hotkeys helper", group = "Main" }
		-- },
		{
			{ env.mod,"Shift" }, "o", function() awful.spawn("openFile") end,
			{ description = "Show hotkeys helper", group = "Main" }
		},
		{
			{ env.mod }, "F1", function() redtip:show() end,
			{ description = "Show hotkeys helper", group = "Main" }
		},
		{
			{ env.mod }, "F2", function () redflat.service.navigator:run() end,
			{ description = "Window control mode", group = "Main" }
		},
		{
			{ env.mod ,"Shift"}, "e", function () awful.spawn("powerMenu") end,
			{ description = "Power Menu", group = "Main" }
		},
		{
			{ env.mod, "Shift" }, "r", awesome.restart,
			{ description = "Reload awesome", group = "Main" }
		},
		{
			{ env.mod }, "c", function() awful.spawn("capture") end,
			{ description = "Capture", group = "GTD" }
		},
		{
			{ env.mod }, "i", function() awful.spawn("capture -k i ''") end,
			{ description = "Capture to inbox", group = "GTD" }
		},
		{
			{ env.mod }, "space", function() awful.spawn("emacsclient -c -e '(progn (add-hook (quote calc-end-hook) (lambda () (delete-frame))) (calc nil t))'") end,
			{ description = "Calculator", group = "GTD" }
		},
		{
			{ env.mod }, "Return", function() awful.spawn(env.terminal) end,
			{ description = "Open a terminal", group = "Main" }
		},
		-- {
		-- 	{ env.mod }, "z",
		-- 	function()
		-- 		local tag=awful.tag.selected()
		-- 		local screen = awful.screen.focused()
		-- 		local current = client.focus or nil

		-- 		local matcher = function (c)
		-- 			-- return awful.rules.match(c, {instance= 'wpp'})
		-- 			return awful.rules.match(c, {class= 'Telegram'})
		-- 		end


		-- 		if current then
		-- 			if current.instance == 'Telegram' then
		-- 				current.minimized = true
		-- 			else

		-- 			awful.client.run_or_raise('Telegram', matcher)
		-- 			-- awful.client.run_or_raise('bash -c "vimb web.whatsapp.com& export APP_PID=$!;sleep 2;xprop -id `xdotool search --pid $APP_PID|tail -n 1` -f WM_CLASS 8s -set WM_CLASS "wpp""', matcher)
		-- 			-- awful.client.run_or_raise('bash -c "surf web.whatsapp.com& export APP_PID=$!;sleep 2;xprop -id `xdotool search --pid $APP_PID|tail -n 1` -f WM_CLASS 8s -set WM_CLASS "wpp""', matcher)
		-- 			client.focus:move_to_screen(screen)
		-- 			client.focus:move_to_tag(tag)
		-- 			awful.screen.focus(screen)

		-- 			tag:view_only()
		-- 			end
		-- 		end
		-- 		if current == nil then
		-- 			awful.client.run_or_raise('Telegram',matcher)
		-- 			-- awful.client.run_or_raise('bash -c "vimb web.whatsapp.com& export APP_PID=$!;sleep 2;xprop -id `xdotool search --pid $APP_PID|tail -n 1` -f WM_CLASS 8s -set WM_CLASS "wpp""', matcher)
		-- 			-- awful.client.run_or_raise('bash -c "surf web.whatsapp.com& export APP_PID=$!;sleep 2;xprop -id `xdotool search --pid $APP_PID|tail -n 1` -f WM_CLASS 8s -set WM_CLASS "wpp""', matcher)
		-- 			client.focus:move_to_screen(screen)
		-- 			client.focus:move_to_tag(tag)
		-- 			awful.screen.focus(screen)
		-- 			tag:view_only()
		-- 		end

		-- 	end,
		-- 	{ description = "Telegram", group = "IM" }
		-- },
		{
			{ env.mod, "Shift" }, "l", swap_switch_byd("right"),
			{ description = "Go to right client", group = "Client focus" }
		},
		{
			{ env.mod }, "l", focus_switch_byd("right"),
			{ description = "Go to right client", group = "Client focus" }
		},
		{
			{ env.mod, "Shift" }, "h", swap_switch_byd("left"),
			{ description = "Go to left client", group = "Client focus" }
		},
		{
			{ env.mod }, "h", focus_switch_byd("left"),
			{ description = "Go to left client", group = "Client focus" }
		},
		{
			{ env.mod, "Shift" }, "k", swap_switch_byd("up"),
			{ description = "Go to upper client", group = "Client focus" }
		},
		{
			{ env.mod }, "k", focus_switch_byd("up"),
			{ description = "Go to upper client", group = "Client focus" }
		},
		{
			{ env.mod,"Shift" }, "j", swap_switch_byd("down"),
			{ description = "Go to lower client", group = "Client focus" }
		},
		{
			{ env.mod }, "j", focus_switch_byd("down"),
			{ description = "Go to lower client", group = "Client focus" }
		},
		{
			{ env.mod }, "u", awful.client.urgent.jumpto,
			{ description = "Go to urgent client", group = "Client focus" }
		},
		-- {
		-- 	{ env.mod }, "Tab", focus_to_previous,
		-- 	{ description = "Go to previous client", group = "Client focus" }
		-- },

		{
			{ env.mod }, "w", function() mainmenu:show() end,
			{ description = "Show main menu", group = "Widgets" }
		},
		{
			{ env.mod }, "r", function() awful.spawn("drun") end,
			-- { env.mod }, "r", function() apprunner:show() end,
			{ description = "Application launcher", group = "Widgets" }
		},
		{
			{ env.mod  }, "e", function() awful.util.spawn("emacsclient -c -a emacs") end,
			{ description = "Emacs", group = "Programs" }
		},
		-- {
		-- 	-- { env.mod  }, "b", function() awful.util.spawn_with_shell("tabbed -c vimb -e") end,
		-- 	{ env.mod  }, "b", function() awful.util.spawn_with_shell("vimb ~/Dropbox/org/agenda.html") end,
		-- 	{ description = "Browser", group = "Programs" }
		-- },
		-- {
		-- 	{ env.mod  }, "b", function() awful.util.spawn_with_shell("tabbed -c surf -e") end,
		-- 	{ description = "Browser", group = "Programs" }
		-- },
		{
			{ env.mod  }, "p", function() awful.util.spawn_with_shell("$SCRIPTSFOLDER/multimonitor") end,
			{ description = "Show the prompt box", group = "Widgets" }
		},
		{
			{ env.mod }, "o", function() awful.spawn("run") end,
			-- { env.mod  }, "o", function() redflat.float.prompt:run() end,
			{ description = "Show the prompt box", group = "Widgets" }
		},
		{
			{ env.mod }, "Tab", function() awful.spawn("chooseWindow") end,
			-- { env.mod  }, "o", function() redflat.float.prompt:run() end,
			{ description = "Show the prompt box", group = "Widgets" }
		},
		{
			{ env.mod, "Control" }, "i", function() redflat.widget.minitray:toggle() end,
			{ description = "Show minitray", group = "Widgets" }
		},
		{
			{ env.mod }, "t", function() awful.titlebar.toggle(client.focus) end,
			{ description = "Show/hide titlebar for focused client", group = "Titlebar" }
		},
		{
			{ env.mod }, "a", nil, function() appswitcher:show({ filter = current }) end,
			{ description = "Switch to next with current tag", group = "Application switcher" }
		},
		{
			{ env.mod }, "q", nil, function() appswitcher:show({ filter = current, reverse = true }) end,
			{ description = "Switch to previous with current tag", group = "Application switcher" }
		},
		{
			{ env.mod, "Shift" }, "a", nil, function() appswitcher:show({ filter = allscr }) end,
			{ description = "Switch to next through all tags", group = "Application switcher" }
		},
		{
			{ env.mod, "Shift" }, "q", nil, function() appswitcher:show({ filter = allscr, reverse = true }) end,
			{ description = "Switch to previous through all tags", group = "Application switcher" }
		},

		{
			{ env.mod }, "Escape", function () awful.spawn("prettyLock") end,
			{ description = "Quick Lock", group = "Main" }
		},
		-- {
		-- 	{ env.mod }, "Escape", awful.tag.history.restore,
		-- 	{ description = "Go previos tag", group = "Tag navigation" }
		-- },
		{
			{ env.mod, "Control" }, "l", awful.tag.viewnext,
			{ description = "View next tag", group = "Tag navigation" }
		},
		{
			{ env.mod , "Control" }, "h", awful.tag.viewprev,
			{ description = "View previous tag", group = "Tag navigation" }
		},

		{
			{ env.mod }, "y", function() laybox:toggle_menu(mouse.screen.selected_tag) end,
			{ description = "Show layout menu", group = "Layouts" }
		},
		{
			{ env.mod }, "Up", function() awful.layout.inc(1) end,
			{ description = "Select next layout", group = "Layouts" }
		},
		{
			{ env.mod }, "Down", function() awful.layout.inc(-1) end,
			{ description = "Select previous layout", group = "Layouts" }
		},
		{
			{ env.mod }, "semicolon",
			function()
				awful.screen.focus_relative(1);
				-- awful.spawn('bash -c "sleep 0.1;xdotool mousemove --window $(xdotool getwindowfocus) --polar 0 0"')
			end,
			{ description = "focus the next screen", group = "Screen" }
		},
		{
			{ env.mod }, "comma",
			function()
				awful.screen.focus_relative(-1);
				-- awful.spawn('bash -c "sleep 0.1;xdotool mousemove --window $(xdotool getwindowfocus) --polar 0 0"')
			end,
			{ description = "focus the previous screen", group = "Screen" }
		}
	}

	-- Client keys
	--------------------------------------------------------------------------------
	self.raw.client = {
		-- from https://github.com/awesomeWM/awesome/issues/2437
		{
			{ env.mod, "Shift"   }, "comma",
			function (c)
				c:move_to_screen(c.screen.index-1)
			end,
			{description = "move to previous screen", group = "Screen"}
		},
		{
			{ env.mod, "Shift"   }, "semicolon",
			function (c)
				c:move_to_screen(c.screen.index+1)
			end,
			{description = "move to next screen", group = "Screen"}
		},
		{
			{ env.mod }, "f", function(c) c.fullscreen = not c.fullscreen; c:raise() end,
			{ description = "Toggle fullscreen", group = "Client keys" }
		},
		{
			{ env.mod }, "F4", function(c) c:kill() end,
			{ description = "Close", group = "Client keys" }
		},
		{
			{ env.mod, "Control" }, "f", awful.client.floating.toggle,
			{ description = "Toggle floating", group = "Client keys" }
		},
		{
			{ env.mod, "Control" }, "o", function(c) c.ontop = not c.ontop end,
			{ description = "Toggle keep on top", group = "Client keys" }
		},
		{
			{ env.mod }, "n", function(c) c.minimized = true end,
			{ description = "Minimize", group = "Client keys" }
		},
		{
			{ env.mod }, "m", function(c) c.maximized = not c.maximized; c:raise() end,
			{ description = "Maximize", group = "Client keys" }
		},
		{
			{ env.mod }, "s", function(c) c.sticky = not c.sticky; c:raise() end,
			{ description = "Sticky", group = "Client keys" }
		},
	}

	self.keys.root = redflat.util.key.build(self.raw.root)
	self.keys.client = redflat.util.key.build(self.raw.client)

	-- Numkeys
	--------------------------------------------------------------------------------

	-- add real keys without description here
	for i = 1, 9 do
		self.keys.root = awful.util.table.join(
			self.keys.root,
			tag_numkey(i,    { env.mod },                     function(t) t:view_only()               end),
			tag_numkey(i,    { env.mod, "Control" },          function(t) awful.tag.viewtoggle(t)     end),
			client_numkey(i, { env.mod, "Shift" },            function(t) client.focus:move_to_tag(t) end),
			client_numkey(i, { env.mod, "Control", "Shift" }, function(t) client.focus:toggle_tag(t)  end)
		)
	end

	-- make fake keys with description special for key helper widget
	local numkeys = { "1", "2", "3", "4", "5", "6", "7", "8", "9" }

	self.fake.numkeys = {
		{
			{ env.mod }, "1..9", nil,
			{ description = "Switch to tag", group = "Numeric keys", keyset = numkeys }
		},
		{
			{ env.mod, "Control" }, "1..9", nil,
			{ description = "Toggle tag", group = "Numeric keys", keyset = numkeys }
		},
		{
			{ env.mod, "Shift" }, "1..9", nil,
			{ description = "Move focused client to tag", group = "Numeric keys", keyset = numkeys }
		},
		{
			{ env.mod, "Control", "Shift" }, "1..9", nil,
			{ description = "Toggle focused client on tag", group = "Numeric keys", keyset = numkeys }
		},
	}

	-- Hotkeys helper setup
	--------------------------------------------------------------------------------
	redflat.float.hotkeys:set_pack("Main", awful.util.table.join(self.raw.root, self.raw.client, self.fake.numkeys), 2)

	-- Mouse buttons
	--------------------------------------------------------------------------------
	self.mouse.client = awful.util.table.join(
		awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
		awful.button({ env.mod }, 1, awful.mouse.client.move),
		awful.button({ env.mod }, 3, awful.mouse.client.resize),
		awful.button({ }, 22, function () awful.spawn("wacomChangeOutput 1") end),
		awful.button({ }, 23, function () awful.spawn("wacomChangeOutput 2") end)
	)

	-- Set root hotkeys
	--------------------------------------------------------------------------------
	root.keys(self.keys.root)
	root.buttons(self.mouse.root)
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return hotkeys
