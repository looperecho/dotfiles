-- Styles and Decorations

-- GENERAL
-- ──────────────
hl.config({
    general = {
        gaps_in  = 10,
        gaps_out = { top = 5, right = 10, bottom = 10, left = 10 },
        border_size = 3,
        col = {
            active_border   = "rgba(9a9a9a33)",
            inactive_border = "rgba(00000044)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    -- DECORATION
    -- ──────────────
    decoration = {
        rounding       = 10,
        active_opacity = 1.0,
        dim_inactive   = false,
        inactive_opacity = 1.0,
        dim_special    = 0.5,

        shadow = {
            enabled = true,
        },

        blur = {
            enabled           = true,
            size              = 9,
            passes            = 4,
            new_optimizations = true,
            ignore_opacity    = true,
            brightness        = 1.0,
            xray              = false,
            vibrancy          = 0.2,
            vibrancy_darkness = 0.2,
            contrast          = 1.0,
            noise             = 0.03,
            popups            = false,
        },
    },

    -- BINDS
    -- ──────────────
    binds = {
        hide_special_on_workspace_change = true,
    },

    -- GROUPS
    -- ──────────────
    group = {
        auto_group = false,
        col = {
            border_active   = { colors = {"rgba(9a9a9acc)", "rgba(7FA5BDCC)"}, angle = 45 },
            border_inactive = "rgba(59595922)",
        },
        groupbar = {
            render_titles    = false,
            indicator_height = 8,
            gaps_out         = 8,
            col = {
                active   = "rgba(7FA5BDCC)",
                inactive = "rgba(59595922)",
            },
        },
    },

    -- MISC
    -- ──────────────
    misc = {
        force_default_wallpaper  = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
    },

    -- LAYOUT OPTIONS
    -- ──────────────
    layout = {
        single_window_aspect_ratio = {8, 9},
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status  = "master",
        orientation = "center",
        mfact       = 0.5,
    },
})

-- ANIMATIONS
-- ──────────────
hl.config({
    animations = {
        enabled = true,
    }
})

-- Define curves
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

-- Apply animations
--                          leaf,                  enabled, speed, bezier,      style
hl.animation({ leaf = "windows",          enabled = true, speed = 3, bezier = "myBezier", style = "gnomed" })
hl.animation({ leaf = "windowsOut",       enabled = true, speed = 3, bezier = "myBezier", style = "popin" })
hl.animation({ leaf = "workspaces",       enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "specialWorkspace", enabled = true, speed = 1, bezier = "myBezier", style = "slidefadevert -50%" })
hl.animation({ leaf = "layersIn",         enabled = true, speed = 1, bezier = "default",  style = "slidefadevert right" })
hl.animation({ leaf = "layersOut",        enabled = true, speed = 100, bezier = "myBezier", style = "slide right" })
hl.animation({ leaf = "fade",             enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "fadeLayers",       enabled = true, speed = 1, bezier = "default" })
