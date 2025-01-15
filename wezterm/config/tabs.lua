return function(config)
    config.use_fancy_tab_bar = false
    config.hide_tab_bar_if_only_one_tab = true
    config.tab_bar_at_bottom = true

    config.colors = {
        split = '#1a1a1a',
        tab_bar = {
            active_tab = {
                fg_color = '#B6B6AA',
                bg_color = '#282828',
            },
        },
    }
end
