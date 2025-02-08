return function(config)
    -- Theme
    config.color_scheme = 'Pnevma'

    -- Color Variables
    local fg = '#9a9a9a'
    local bg = '#1a2023'
    local bg_alpha = 'rgba(255,255,255,0.1)'
    local transparent = 'rgba(0,0,0,0)'

    -- Overrides
    config.colors = {
        foreground = fg,
        background = bg,

        -- Tabs and splits
        split = bg_alpha,

        tab_bar = {
            background = bg_alpha,
            active_tab = {
                fg_color = fg,
                bg_color = transparent,
            },
            inactive_tab = {
                fg_color = fg,
                bg_color = bg_alpha,
            },
            new_tab = {
                fg_color = fg,
                bg_color = bg_alpha,
            },
        },
    }

    -- Tab Styling
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_at_bottom = true
end
