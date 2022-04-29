local dracula = require 'theme/dracula';
local wezterm = require 'wezterm';

return {
    colors = dracula,
    tab_bar_at_bottom = false,
    use_fancy_tab_bar = false,
    enable_tab_bar = false,
    enable_scroll_bar = true,
    window_background_opacity = 0.8,
    text_background_opacity = 1.0,
    font = wezterm.font("JetBrains Mono", {weight="Bold", italic=false}),
    font_size = 12,
    window_close_confirmation = "NeverPrompt",
    window_padding = {
      left = 0,
      right = 0,
      top = 0,
      bottom = 0,
    }
}
