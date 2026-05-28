local wezterm = require("wezterm")

return {
	default_prog = { "fish" },
	hide_tab_bar_if_only_one_tab = true,

	color_scheme = "Everforest Dark Hard (Gogh)",

	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" }),
	font_size = 10,

	-- Don't override SSH_AUTH_SOCK
	-- https://github.com/wezterm/wezterm/issues/7324
	mux_enable_ssh_agent = false,
}
