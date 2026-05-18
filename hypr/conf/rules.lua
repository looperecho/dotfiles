-- Workspace and Window Rules

-- TAG RULES
-- ──────────────
hl.window_rule({ match = { initial_class = "(firefox)|(zen)"                          }, tag = "+browser"  })
hl.window_rule({ match = { initial_class = "(Alacritty)|(org.wezfurlong.wezterm)|(com.mitchellh.ghostty)" }, tag = "+terminal" })
hl.window_rule({ match = { initial_class = "(org.gnome.Nautilus)"                     }, tag = "+fileman"  })
hl.window_rule({ match = { initial_class = "^[Ss]potify"                              }, tag = "+media"    })
hl.window_rule({ match = { initial_class = "(^[Vv]esktop)|(^[Dd]iscord)"              }, tag = "+social"   })
hl.window_rule({ match = { initial_class = "(steam_app_)(%d*)"                        }, tag = "+game"     })

-- WORKSPACE RULES
-- ──────────────
hl.window_rule({ match = { tag = "terminal" },                workspace = "1"  })
hl.window_rule({ match = { tag = "browser"  },                workspace = "2"  })
hl.window_rule({ match = { tag = "fileman"  },                workspace = "3"  })
hl.window_rule({ match = { initial_class = "steam" },         workspace = "4"  })
hl.window_rule({ match = { tag = "game"     },                workspace = "10" })

-- SPECIAL WORKSPACE
-- ──────────────
hl.window_rule({ match = { tag = "media"  }, workspace = "special:magic" })
hl.window_rule({ match = { tag = "social" }, workspace = "special:magic" })

-- FLOATING WINDOWS
-- ──────────────
-- Border style for floating windows
hl.window_rule({ match = { float = true }, border_color = "rgba(9a9a9a99)" })

-- Nautilus Previewer
hl.window_rule({ match = { class = "org.gnome.NautilusPreviewer" }, float = true })

-- Picture-in-Picture
hl.window_rule({
    name  = "pip-window",
    match = { title = "Picture-in-Picture" },
    float = true,
    pin   = true,
    move  = {2912, 1637},
    opacity = "1",
})

-- iBus popup
hl.window_rule({
    name  = "ibus-popup",
    match = { title = "ibus-ui-gtk3" },
    float   = true,
    size    = {"window_w/5", "window_y/8"},
    center  = true,
    decorate = false,
})

-- Generic floating popups: centre them
hl.window_rule({
    name  = "center-popups",
    match = { float = true },
    center = true,
})

-- SPECIFIC WINDOW RULES
-- ──────────────
-- Games: no border or rounding
hl.window_rule({ match = { tag = "game" }, border_size = 0 })
hl.window_rule({ match = { tag = "game" }, rounding    = 0 })

-- LAYER RULES
-- ──────────────
-- slurp selection overlay: no animation
hl.layer_rule({ match = { class = "selection" }, no_anim = true })

-- swaync / launchers: fade animation + blur + ignore_alpha
hl.layer_rule({ match = { namespace = "(ulauncher)|(rofi)" }, animation    = "fadeLayers" })
hl.layer_rule({ match = { namespace = "(ulauncher)|(rofi)|(swaync-control-center)|(swaync-notification-window)" }, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "(ulauncher)|(rofi)|(swaync-control-center)|(swaync-notification-window)" }, blur         = true })
