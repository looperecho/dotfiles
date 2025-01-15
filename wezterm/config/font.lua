local wezterm = require 'wezterm'

return function(config)
    -- Font
    config.font = wezterm.font('FiraCode Nerd Font', { weight = 'Regular' })
    config.font_size = 14.0
    config.freetype_load_flags = 'NO_HINTING'
    config.bold_brightens_ansi_colors = true
end
