-- ---- ---- ---- ---- ---- ----
-- Wezterm custom keybindings
-- ---- ---- ---- ---- ---- ----

local wezterm = require 'wezterm'
local wez = wezterm.action

return function(config)
    config.keys = {
        ----
        ---- Tab Naviation ----
        ----
        {
            key = 'k',
            mods = 'CTRL|SHIFT',
            action = wez.ActivateTabRelative(1),
        },
        {
            key = 'j',
            mods = 'CTRL|SHIFT',
            action = wez.ActivateTabRelative(-1),
        },
        {
            key = 'F1',
            action = wez.ActivateTab(0),
        },
        {
            key = 'F2',
            action = wez.ActivateTab(1),
        },
        {
            key = 'F3',
            action = wez.ActivateTab(2),
        },
        {
            key = 'F4',
            action = wez.ActivateTab(3),
        },
        {
            key = 'F5',
            action = wez.ActivateTab(4),
        },
        {
            key = 'F6',
            action = wez.ActivateTab(5),
        },
        {
            key = 'F7',
            action = wez.ActivateTab(6),
        },
        {
            key = 'F8',
            action = wez.ActivateTab(7),
        },

        ----
        ---- Splits ----
        ----
        {
            key = '_',
            mods = 'CTRL|SHIFT',
            action = wez.SplitVertical { domain="CurrentPaneDomain" },
        },
        {
            key = '|',
            mods = 'CTRL|SHIFT',
            action = wez.SplitHorizontal { domain="CurrentPaneDomain" },
        },

    }
end
