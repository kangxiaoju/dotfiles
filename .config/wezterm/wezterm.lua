local dracula = require 'theme/dracula';
local catppuccin = require("theme/catppuccin").setup {}
local wezterm = require 'wezterm';

-- wezterm.on(
-- 	"update-right-status",
-- 	function(window)
-- 		local date = wezterm.strftime("%Y-%m-%d %H:%M:%S ")
-- 		window:set_right_status(
-- 			wezterm.format(
-- 				{
-- 					{Text = date}
-- 				}
-- 			)
-- 		)
-- 	end
-- )

return {
  color_scheme = "Catppuccin Mocha",
  tab_bar_at_bottom = false,
  until_unknown=true,
  use_fancy_tab_bar = false,
  enable_tab_bar = true,
  enable_scroll_bar = false,
  window_background_opacity = 0.8,
  text_background_opacity = 1.0,
  hide_tab_bar_if_only_one_tab = true,
  font = wezterm.font("Hack Nerd Font Mono"),
  initial_cols = 150,
  initial_rows = 45,
  font_size = 15,
  window_close_confirmation = "NeverPrompt",
  window_decorations = "RESIZE",
  window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 0,
  },
  keys = {
    { key = "1", mods = "ALT", action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "ALT", action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "ALT", action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "ALT", action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "ALT", action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "ALT", action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "ALT", action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "ALT", action=wezterm.action{ActivateTab=7}},
    { key = "9", mods = "ALT", action=wezterm.action{ActivateTab=8}},
    { key = "v", mods = "CTRL|SHIFT", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
		{ key = "|", mods = "CTRL|SHIFT", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
		{ key = "t", mods = "CTRL|SHIFT", action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "h", mods = "CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Left"}},
		{ key = "k", mods = "CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Up"}},
		{ key = "j", mods = "CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Down"}},
		{ key = "l", mods = "CTRL|SHIFT", action=wezterm.action{ActivatePaneDirection="Right"}},
  },
}
