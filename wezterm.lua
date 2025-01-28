local wezterm = require("wezterm")

local launch_menu = {
	{
		args = { "btop" },
	},
	{
		label = "Scratchpad",
		args = { "nvim", "/home/mrnugget/tmp/scratchpad.md" },
		set_environment_variables = { KITTY_COLORS = "dark" },
	},
}

local colors = {
	foreground = "#fbf1c7",
	background = "#1d2021",

	cursor_bg = "#928374",
	cursor_fg = "black",
	cursor_border = "#928374",

	selection_fg = "#928374",
	selection_bg = "#ebdbb2",

	scrollbar_thumb = "#222222",

	-- The color of the split lines between panes
	split = "#444444",

	ansi = {
		"#1d2021", -- black, color 0
		"#cc241d", -- red, color 1
		"#98971a", -- green, color 2
		"#d79921",
		"#458588",
		"#b16286",
		"#689d6a",
		"#a89984",
	},
	brights = {
		"#7c6f64", -- black, color 0
		"#fb4934", -- red, color 1
		"#b8bb26", -- green, color 2
		"#fabd2f",
		"#83a598",
		"#d3869b",
		"#8ec07c",
		"#fbf1c7",
	},
}

local is_macos = wezterm.target_triple:match("darwin") ~= nil
local function wayland_enabled()
	local wayland = os.getenv("XDG_SESSION_TYPE")
	return wayland == "wayland"
end

local font_size = 11.0
if wayland_enabled() or is_macos then
	font_size = 12.0
end

return {
	-- See: https://wezfurlong.org/wezterm/config/lua/config/term.html
	-- term = "wezterm",

	enable_tab_bar = false,

	font = wezterm.font("Berkeley Mono Nerd Font"),
	font_size = font_size,

	launch_menu = launch_menu,

	-- Use this, but then overwrite it basically completely further down
	color_scheme = "Gruvbox Dark",
	colors = colors,

	keys = {
		{
			key = "f",
			mods = "SHIFT|SUPER",
			action = wezterm.action.ToggleFullScreen,
		},
	},
}
