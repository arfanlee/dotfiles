-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
local vicious = require("vicious")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors})
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({preset = naughty.config.presets.critical,
                         title = "Oops, an error happened!",
                         text = tostring(err)})
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- This is used later as the default terminal, modkey and editor to run.
local my_terminal = "xterm"
local my_browser = "firefox"
local my_fm = "nemo"
local my_clipboard = "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'"
local my_runner = "rofi -show drun"
local my_screencapture = "scrot ~/Pictures/Screenshots/%Y-%m-%d_%H-%M-%S.png"
local my_soundplayer = "ffplay -nodisp -autoexit"
local shutter_sound = " /opt/sys-sounds/cam-shutter.wav"
local my_modkey = "Mod4"
local my_editor = os.getenv("EDITOR") or "nvim"
local editor_cmd = my_terminal .. " -e " .. my_editor

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.max,
    awful.layout.suit.tile,
    awful.layout.suit.tile.left,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.floating,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.magnifier,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}

-- Create a launcher widget and a main menu
local my_awesome_menu = {
	{"hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end},
    {"manual", my_terminal .. " -e man awesome"},
    {"edit config", editor_cmd .. " " .. awesome.conffile},
    {"restart", awesome.restart},
    {"quit", function() awesome.quit() end},
}
 
local my_mainmenu = awful.menu({items = {{"awesome", my_awesome_menu, beautiful.awesome_icon},
                                   {"open terminal", my_terminal}
                                  }
                         })

local my_launcher = awful.widget.launcher({image = beautiful.awesome_icon,
                                     menu = my_mainmenu})

-- Menubar configuration
menubar.utils.terminal = my_terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
	awful.button({}, 1, function(t) t:view_only() end),
	awful.button({my_modkey}, 1, function(t)
		if client.focus then
			client.focus:move_to_tag(t)
		end
	end),
	awful.button({}, 3, awful.tag.viewtoggle),
	awful.button({my_modkey}, 3, function(t)
		if client.focus then
			client.focus:toggle_tag(t)
		end
	end),
	awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
	awful.button({}, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
	awful.button({}, 1, function(c)
		if c == client.focus then
			c.minimized = true
		else
			c:emit_signal("request::activate", "tasklist", {raise = true})
		end
	end),
	awful.button({}, 3, function()
		awful.menu.client_list({theme = {width = 250}})
		end),
	awful.button({}, 4, function()
		awful.client.focus.byidx(1)
		end),
	awful.button({}, 5, function()
		awful.client.focus.byidx(-1)
		end))

-- vicious.register(widget_name, format/functions, intervals)
-- Network widget
local wifi_icon = wibox.widget.textbox("  ")
local wifi_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.wifiiw)
vicious.register(wifi_widget, vicious.widgets.wifiiw, " ${ssid} ", 1.5, "wlan0")

-- Sound widget
local vol_icon = wibox.widget.textbox("  ")
local vol_widget = wibox.widget.textbox()
vicious.register(vol_widget, vicious.widgets.volume,
        function(widget, args)
        if args[2] == "♩" then
            return '<span color="#F2241F"><b> </b>' .. args[2] .. '</span>'
        else
            return " " .. args[1] .. "% "
        end
        end,
   1, "Master")

-- CPU widget
local cpu_icon = wibox.widget.textbox("  ")
local cpu_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.cpu)
vicious.register(cpu_widget, vicious.widgets.cpu, " $1% ", 1.5)
cpu_widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() --left click 
        awful.spawn(my_terminal .. " -e htop")
    end)
))

-- Memory widget
local ram_icon = wibox.widget.textbox("  ")
local ram_widget = wibox.widget.textbox()
vicious.cache(vicious.widgets.mem)
vicious.register(ram_widget, vicious.widgets.mem, " $1% ", 1.5)
ram_widget:buttons(awful.util.table.join(
    awful.button({}, 1, function() --left click 
        awful.spawn(my_terminal .. " -e htop")
    end)
))

-- Date widget
local date_icon = wibox.widget.textbox("  ")
local date_widget = wibox.widget.textbox()
vicious.register(date_widget, vicious.widgets.date, " %a, %h %d %H:%M", 1)
local date_pop = awful.widget.calendar_popup.month({long_weekdays=true, start_sunday=true, margin=10})
date_pop:attach(date_widget, "tr")

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)
awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({"1", "2", "3", "4", "5"}, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.my_taglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
		widget_template = {
			{
				layout = wibox.layout.align.horizontal,
				{
					layout = wibox.layout.fixed.vertical,
					{
						{
							id = 'text_role',
							align = "center",
							widget = wibox.widget.textbox
						},
						top = 4,
						widget = wibox.container.margin
					},
					{
						{
							left = 12,
							right = 12,
							top = 3,
							widget = wibox.container.margin
						},
						id = 'underline',
						bg = '#3325a1',
						shape = gears.shape.rectangle,
						widget = wibox.container.background
					}
				}
			},
			-- got these underline border hack from
			-- https://www.reddit.com/r/awesomewm/comments/74a8h2/help_how_to_underline_wibox_widgets/
			id = 'background_role',
			widget = wibox.container.background,
			shape = gears.shape.rectangle,
			create_callback = function(self, c3, index, objects)
				local focused = false
				for _, x in pairs(awful.screen.focused().selected_tags) do
					if x.index == index then
						focused = true
						break
					end
				end
				if focused then -- when tag is selected
					self:get_children_by_id("underline")[1].bg = beautiful.bg_focus
				else
					self:get_children_by_id("underline")[1].bg = "#FFFFFF00" -- transparent
				end
				self:connect_signal('mouse::enter', function() -- change taglist bg on hover
					if self.bg ~= beautiful.bg_minimize then
						self.backup     = self.bg
						self.has_backup = true
					end
					self.bg = beautiful.bg_minimize
				end)
				self:connect_signal('mouse::leave', function() -- revert back to normal when mouse left
					if self.has_backup then self.bg = self.backup end
				end)
			end,
			update_callback = function(self, c3, index, objects)
				local focused = false
				for _, x in pairs(awful.screen.focused().selected_tags) do
					if x.index == index then
						focused = true
						break
					end
				end
				if focused then
					self:get_children_by_id("underline")[1].bg = beautiful.bg_focus
				else
					self:get_children_by_id("underline")[1].bg = "#FFFFFF00" -- transparent
				end
			end
		},
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.my_tasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons
    }

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen (the icon on the top right corner).
    s.my_layoutbox = awful.widget.layoutbox(s)
    s.my_layoutbox:buttons(gears.table.join(
                           awful.button({}, 1, function() awful.layout.inc(1) end),
                           awful.button({}, 3, function() awful.layout.inc(-1) end),
                           awful.button({}, 4, function() awful.layout.inc(1) end),
                           awful.button({}, 5, function() awful.layout.inc(-1) end)))


    -- Create the wibox
    s.mywibox = awful.wibar({height = 25, position = "top", screen = s})

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
			my_launcher,
			{
				s.my_taglist,
				left = 5,
				right = 5,
				layout = wibox.container.margin,
			},
        },
		{ -- Middle tasklist
            layout = wibox.layout.flex.horizontal,
			{
				s.my_tasklist,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			}
		},

        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
			{ -- {{ Wi-Fi
				{
					wifi_icon,
					fg = beautiful.bg_normal,
					bg = "#FFA066",
					widget = wibox.container.background
				},
				top = 2,
				bottom = 2,
				left = 5,
				layout = wibox.container.margin
			},
			{
				{
					wifi_widget,
					fg = "#FFA066",
					color = beautiful.fg_widget,
					widget = wibox.container.background
				},
				right = 5,
				top = 2,
				bottom = 2,
				forced_width = 60,
				layout = wibox.container.margin,
			}, -- }}
			{ -- {{ Volume
				{
					vol_icon,
					fg = beautiful.bg_normal,
					bg = "#E6C384",
					widget = wibox.container.background
				},
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			},
			{
				{
					vol_widget,
					fg = "#E6C384",
					color = beautiful.fg_widget,
					widget = wibox.container.background
				},
				forced_width = 55,
				right = 5,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			}, -- }}
			{ -- {{ CPU
				{
					cpu_icon,
					fg = beautiful.bg_normal,
					bg = "#76946A",
					widget = wibox.container.background
				},
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			},
			{
				{
					cpu_widget,
					fg = "#76946A",
					color = beautiful.fg_widget,
					widget = wibox.container.background
				},
				forced_width = 45,
				right = 5,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			}, -- }}
			{ -- {{ RAM
				{
					ram_icon,
					fg = beautiful.bg_normal,
					bg = "#7E9CD8",
					widget = wibox.container.background
				},
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			},
			{
				{
					ram_widget,
					fg = "#7E9CD8",
					color = beautiful.fg_widget,
					widget = wibox.container.background
				},
				forced_width = 45,
				right = 5,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			}, -- }}
			{ -- {{ Datetime
				{
					date_icon,
					fg = beautiful.bg_normal,
					bg = "#957FB8",
					widget = wibox.container.background
				},
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			},
			{
				{
					date_widget,
					fg = "#957FB8",
					color = beautiful.fg_widget,
					widget = wibox.container.background
				},
				right = 5,
				top = 2,
				bottom = 2,
				layout = wibox.container.margin
			}, -- }}
			{
				wibox.widget.systray(),
				top = 2,
				bottom = 2,
				left = 5,
				right = 5,
				layout = wibox.container.margin
			},
            s.my_layoutbox
        }
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({}, 3, function() my_mainmenu:toggle() end)
	-- mouse scrolling bindings when mouse is not focused on a client
    -- awful.button({}, 4, awful.tag.viewnext),
    -- awful.button({}, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
local global_keys = gears.table.join(
    awful.key({my_modkey}, "s", hotkeys_popup.show_help, {description = "show help", group = "awesome"}),
    awful.key({my_modkey}, "Left", awful.tag.viewprev, {description = "view previous", group = "tag"}),
    awful.key({my_modkey}, "Right", awful.tag.viewnext, {description = "view next", group = "tag"}),
    awful.key({my_modkey}, "Escape", awful.tag.history.restore, {description = "go back", group = "tag"}),
    awful.key({my_modkey}, "j",
        function()
            awful.client.focus.byidx(1)
        end,
        {description = "focus next by index", group = "client"}),
    awful.key({my_modkey}, "k",
        function()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}),
    awful.key({my_modkey}, "w", function() my_mainmenu:show() end, {description = "show main menu", group = "awesome"}),

	-- Volume
	awful.key({}, "XF86AudioLowerVolume",
              function()
                  awful.util.spawn_with_shell("pactl set-sink-mute 0 false ; pactl -- set-sink-volume 0 -5%")
              end,{description = "Decrease sound volume", group = "awesome"}),
    awful.key({}, "XF86AudioRaiseVolume",
              function()
                  awful.util.spawn_with_shell("pactl set-sink-mute 0 false ; pactl -- set-sink-volume 0 +5%")
              end,{description = "Increase sound volume", group = "awesome"}),
    awful.key({}, "XF86AudioMute",
              function() awful.util.spawn_with_shell("pactl set-sink-mute 0 toggle")
              end,{description = "Mute sound", group = "awesome"}),

    -- Layout manipulation
    awful.key({my_modkey, "Shift"}, "j", function() awful.client.swap.byidx(1) end,
              {description = "swap with next client by index", group = "client"}),
    awful.key({my_modkey, "Shift"}, "k", function() awful.client.swap.byidx(-1) end,
              {description = "swap with previous client by index", group = "client"}),
    awful.key({my_modkey, "Control"}, "j", function() awful.screen.focus_relative(1) end,
              {description = "focus the next screen", group = "screen"}),
    awful.key({my_modkey, "Control"}, "k", function() awful.screen.focus_relative(-1) end,
              {description = "focus the previous screen", group = "screen"}),
    awful.key({my_modkey}, "u", awful.client.urgent.jumpto,
              {description = "jump to urgent client", group = "client"}),
    awful.key({my_modkey}, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({my_modkey}, "Return", function() awful.spawn(my_terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({my_modkey}, "b", function() awful.spawn(my_browser) end,
              {description = "open a web browser", group = "launcher"}),
    awful.key({my_modkey, "Shift"}, "f", function() awful.spawn(my_fm) end,
              {description = "open a file manager", group = "launcher"}),
    awful.key({my_modkey}, "Print",
			  function() awful.util.spawn_with_shell(my_screencapture)
			  awful.util.spawn_with_shell(my_soundplayer..shutter_sound) end,
              {description = "take a screenshot", group = "launcher"}),
	awful.key({my_modkey}, "p",
			   function() awful.util.spawn_with_shell(my_clipboard) end,
              {description = "launch clipboard manager", group = "launcher"}),
    awful.key({my_modkey, "Control"}, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({my_modkey, "Shift"}, "q", awesome.quit,
              {description = "quit awesome", group = "awesome"}),
    awful.key({my_modkey}, "l", function() awful.tag.incmwfact(0.05) end,
              {description = "increase master width factor", group = "layout"}),
    awful.key({my_modkey}, "h", function() awful.tag.incmwfact(-0.05) end,
              {description = "decrease master width factor", group = "layout"}),
    awful.key({my_modkey, "Shift"}, "h", function() awful.tag.incnmaster(1, nil, true) end,
              {description = "increase the number of master clients", group = "layout"}),
    awful.key({my_modkey, "Shift"}, "l", function() awful.tag.incnmaster(-1, nil, true) end,
              {description = "decrease the number of master clients", group = "layout"}),
    awful.key({my_modkey, "Control"}, "h", function() awful.tag.incncol(1, nil, true) end,
              {description = "increase the number of columns", group = "layout"}),
    awful.key({my_modkey, "Control"}, "l", function() awful.tag.incncol(-1, nil, true) end,
              {description = "decrease the number of columns", group = "layout"}),
    awful.key({my_modkey}, "space", function() awful.layout.inc(1) end,
              {description = "select next", group = "layout"}),
    awful.key({my_modkey, "Shift"}, "space", function() awful.layout.inc(-1) end,
              {description = "select previous", group = "layout"}),

    awful.key({my_modkey, "Control"}, "n",
              function()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:emit_signal(
                        "request::activate", "key.unminimize", {raise = true}
                    )
                  end
              end,
              {description = "restore minimized", group = "client"}),

    -- Prompt
    awful.key({my_modkey}, "r", function() awful.spawn(my_runner) end,
              {description = "run rofi", group = "launcher"})
)

local clientkeys = gears.table.join(
    awful.key({my_modkey}, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({my_modkey}, "q", function (c) c:kill() end,
              {description = "close", group = "client"}),
    awful.key({my_modkey, "Control"}, "space",  awful.client.floating.toggle,
              {description = "toggle floating", group = "client"}),
    awful.key({my_modkey, "Control"}, "Return", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({my_modkey}, "o", function (c) c:move_to_screen() end,
              {description = "move to screen", group = "client"}),
    awful.key({my_modkey}, "t", function (c) c.ontop = not c.ontop end,
              {description = "toggle keep on top", group = "client"}),
    awful.key({my_modkey}, "n",
        function (c)
            -- The client currently has the input focus, so it cannot be
            -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end,
        {description = "minimize", group = "client"}),
    awful.key({my_modkey}, "m",
        function (c)
            c.maximized = not c.maximized
            c:raise()
        end,
        {description = "(un)maximize", group = "client"}),
    awful.key({my_modkey, "Control"}, "m",
        function (c)
            c.maximized_vertical = not c.maximized_vertical
            c:raise()
        end ,
        {description = "(un)maximize vertically", group = "client"}),
    awful.key({my_modkey,"Shift"}, "m",
        function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c:raise()
        end ,
        {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    global_keys = gears.table.join(global_keys,
        -- View tag only.
        awful.key({my_modkey}, "#" .. i + 9,
                  function()
                        local screen = awful.screen.focused()
                        local tag = screen.tags[i]
                        if tag then
                           tag:view_only()
                        end
                  end,
                  {description = "view tag #"..i, group = "tag"}),
        -- Toggle tag display.
        awful.key({my_modkey, "Control"}, "#" .. i + 9,
                  function()
                      local screen = awful.screen.focused()
                      local tag = screen.tags[i]
                      if tag then
                         awful.tag.viewtoggle(tag)
                      end
                  end,
                  {description = "toggle tag #" .. i, group = "tag"}),
        -- Move client to tag.
        awful.key({my_modkey, "Shift"}, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:move_to_tag(tag)
                          end
                     end
                  end,
                  {description = "move focused client to tag #" .. i, group = "tag"}),
        -- Toggle tag on focused client.
        awful.key({my_modkey, "Control", "Shift"}, "#" .. i + 9,
                  function()
                      if client.focus then
                          local tag = client.focus.screen.tags[i]
                          if tag then
                              client.focus:toggle_tag(tag)
                          end
                      end
                  end,
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

local clientbuttons = gears.table.join(
	-- Left click function
    awful.button({}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
	-- To move around the selected window (Mod4 + Left click)
    awful.button({my_modkey}, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
	-- To resize the selected window (Mod4 + Right click)
    awful.button({my_modkey}, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

-- Set keys
root.keys(global_keys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {rule = {},
      properties = {border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.centered + awful.placement.no_overlap + awful.placement.no_offscreen,
					size_hints_honor = false
     }
    },

    -- Floating clients.
    {rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
		  "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = {floating = true}},

    -- Add titlebars to normal clients and dialogs
    {rule_any = {type = {"normal", "dialog"}},
	 properties = {titlebars_enabled = false}
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    {rule = {class = my_browser},
    properties = {screen = 1, tag = "2"}},
	-- Set Nemo to map on the named "3" on screen 1
    {rule = {class = "Nemo"}, -- lowercase doesn't work
    properties = {screen = 1, tag = "3"}},
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.resize(c)
        end)
    )

    awful.titlebar(c) : setup {
        { -- Left
            awful.titlebar.widget.iconwidget(c),
            buttons = buttons,
            layout  = wibox.layout.fixed.horizontal
        },
        { -- Middle
            { -- Title
                align  = "center",
                widget = awful.titlebar.widget.titlewidget(c)
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        { -- Right
            awful.titlebar.widget.maximizedbutton(c),
            awful.titlebar.widget.closebutton    (c),
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

-- Un/comment for gaps
beautiful.useless_gap = 5
beautiful.gap_single_client = true

-- Enable sloppy focus, so that focus follows mouse.
--client.connect_signal("mouse::enter", function(c)
--    c:emit_signal("request::activate", "mouse_enter", {raise = false})
--end)

-- Start daemons
awful.util.spawn_with_shell("greenclip daemon")

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
