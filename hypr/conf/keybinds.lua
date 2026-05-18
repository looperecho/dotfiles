-- Keybinds

-- import app definitions
local apps = require("conf/apps")

-- DEFINE MODS
-- ──────────────
local mainMod = "SUPER + SHIFT + ALT + CTRL"  -- "HYPER" key
local moveMod = "SUPER"
local subMod  = "SHIFT + ALT + CTRL"

-- GENERAL
-- ──────────────
-- Quit
hl.bind("CTRL + q",          hl.dsp.window.kill())

-- Reloads
hl.bind(subMod .. " + b",    hl.dsp.exec_cmd("killall waybar ; waybar & disown"))
hl.bind(subMod .. " + s",    hl.dsp.exec_cmd("swaync-client -R && swaync-client -rs"))
hl.bind(subMod .. " + h",    hl.dsp.exec_cmd("hyprctl reload"))

-- Screenshot
hl.bind("Print",             hl.dsp.exec_cmd("~/.config/hypr/bin/screenshot.sh"))

-- Screen Record
hl.bind("SHIFT + Print",     hl.dsp.exec_cmd("~/.config/hypr/bin/wf-record-toggle.sh"))

-- Notification Centre
hl.bind(mainMod .. " + n",   hl.dsp.exec_cmd("swaync-client -t"))

-- LAUNCHERS
-- ──────────────
-- bindr (fires on key release)
hl.bind(mainMod .. " + space", hl.dsp.exec_cmd(apps.menu),     { release = true })
hl.bind("ALT + 1",             hl.dsp.exec_cmd(apps.terminal))
hl.bind("ALT + 2",             hl.dsp.exec_cmd(apps.browser))
hl.bind("ALT + 3",             hl.dsp.exec_cmd(apps.fileManager))
hl.bind("ALT + 4",             hl.dsp.exec_cmd("steam"))
hl.bind("ALT + 5",             hl.dsp.exec_cmd(apps.media))
hl.bind("ALT + 6",             hl.dsp.exec_cmd(apps.social))

-- Rofi -> on release
hl.bind("SUPER + space",       hl.dsp.exec_cmd("pkill rofi || rofi -show drun"), { release = true })

-- LAYOUT
-- ──────────────
-- Fullscreen modes
hl.bind(moveMod .. " + F",     hl.dsp.window.fullscreen({ mode = 1 }))
hl.bind(subMod .. " + F",      hl.dsp.window.fullscreen({ mode = 0 }))

-- Float toggle, move centre
hl.bind(moveMod .. " + V",     hl.dsp.window.float({ action = "toggle" }))
hl.bind(moveMod .. " + C",     hl.dsp.window.center())

-- NAVIGATION — Windows (focus)
-- ──────────────
-- Arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))
-- WASD
hl.bind(mainMod .. " + a",     hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + d",     hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + w",     hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + s",     hl.dsp.focus({ direction = "d" }))
-- hjkl
hl.bind(mainMod .. " + h",     hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l",     hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k",     hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j",     hl.dsp.focus({ direction = "d" }))

-- NAVIGATION — Workspaces
-- ──────────────
hl.bind(mainMod .. " + 1",      hl.dsp.focus({ workspace = "1"  }))
hl.bind(mainMod .. " + 2",      hl.dsp.focus({ workspace = "2"  }))
hl.bind(mainMod .. " + 3",      hl.dsp.focus({ workspace = "3"  }))
hl.bind(mainMod .. " + 4",      hl.dsp.focus({ workspace = "4"  }))
hl.bind(mainMod .. " + 5",      hl.dsp.focus({ workspace = "5"  }))
hl.bind(mainMod .. " + 6",      hl.dsp.focus({ workspace = "6"  }))
hl.bind(mainMod .. " + 7",      hl.dsp.focus({ workspace = "7"  }))
hl.bind(mainMod .. " + 8",      hl.dsp.focus({ workspace = "8"  }))
hl.bind(mainMod .. " + 9",      hl.dsp.focus({ workspace = "9"  }))
hl.bind(mainMod .. " + 0",      hl.dsp.focus({ workspace = "10" }))
-- Prev / Next
hl.bind(mainMod .. " + q",      hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + e",      hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + comma",  hl.dsp.focus({ workspace = "-1" }))
hl.bind(mainMod .. " + period", hl.dsp.focus({ workspace = "+1" }))
-- Cycle (active)
hl.bind(mainMod .. " + Tab",    hl.dsp.focus({ workspace = "e+1" }))
hl.bind("ALT + Tab",            hl.dsp.focus({ workspace = "e+1" }))
-- Mouse scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "-1" }))

-- MOVEMENT — Windows
-- ──────────────
-- Arrow keys
hl.bind(moveMod .. " + left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(moveMod .. " + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(moveMod .. " + up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(moveMod .. " + down",  hl.dsp.window.move({ direction = "d" }))
-- WASD — movewindoworgroup (moves through groups too)
-- NOTE: if hl.dsp.window.move doesn't support or_group, check the Dispatchers wiki page
hl.bind(moveMod .. " + a",     hl.dsp.window.move({ direction = "l", or_group = true }))
hl.bind(moveMod .. " + d",     hl.dsp.window.move({ direction = "r", or_group = true }))
hl.bind(moveMod .. " + w",     hl.dsp.window.move({ direction = "u", or_group = true }))
hl.bind(moveMod .. " + s",     hl.dsp.window.move({ direction = "d", or_group = true }))
-- hjkl
hl.bind(moveMod .. " + h",     hl.dsp.window.move({ direction = "l" }))
hl.bind(moveMod .. " + l",     hl.dsp.window.move({ direction = "r" }))
hl.bind(moveMod .. " + k",     hl.dsp.window.move({ direction = "u" }))
hl.bind(moveMod .. " + j",     hl.dsp.window.move({ direction = "d" }))
-- Swap split (dwindle)
hl.bind(moveMod .. " + z",     hl.dsp.layout("swapsplit"))

-- MOVEMENT — Workspaces (move window to workspace)
-- ──────────────
hl.bind(moveMod .. " + 1",      hl.dsp.window.move({ workspace = "1"  }))
hl.bind(moveMod .. " + 2",      hl.dsp.window.move({ workspace = "2"  }))
hl.bind(moveMod .. " + 3",      hl.dsp.window.move({ workspace = "3"  }))
hl.bind(moveMod .. " + 4",      hl.dsp.window.move({ workspace = "4"  }))
hl.bind(moveMod .. " + 5",      hl.dsp.window.move({ workspace = "5"  }))
hl.bind(moveMod .. " + 6",      hl.dsp.window.move({ workspace = "6"  }))
hl.bind(moveMod .. " + 7",      hl.dsp.window.move({ workspace = "7"  }))
hl.bind(moveMod .. " + 8",      hl.dsp.window.move({ workspace = "8"  }))
hl.bind(moveMod .. " + 9",      hl.dsp.window.move({ workspace = "9"  }))
hl.bind(moveMod .. " + 0",      hl.dsp.window.move({ workspace = "10" }))
-- Prev / Next
hl.bind(moveMod .. " + q",      hl.dsp.window.move({ workspace = "-1" }))
hl.bind(moveMod .. " + e",      hl.dsp.window.move({ workspace = "+1" }))
hl.bind(moveMod .. " + comma",  hl.dsp.window.move({ workspace = "-1" }))
hl.bind(moveMod .. " + period", hl.dsp.window.move({ workspace = "+1" }))
-- Mouse scroll
hl.bind(moveMod .. " + mouse_down", hl.dsp.window.move({ workspace = "+1" }))
hl.bind(moveMod .. " + mouse_up",   hl.dsp.window.move({ workspace = "-1" }))
-- Mouse drag to move
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag())

-- RESIZE — Windows
-- ──────────────
-- WASD
hl.bind(subMod .. " + a",     hl.dsp.window.resize({ x = -80, y = 0,   relative = true }))
hl.bind(subMod .. " + d",     hl.dsp.window.resize({ x = 80,  y = 0,   relative = true }))
hl.bind(subMod .. " + s",     hl.dsp.window.resize({ x = 0,   y = 80,  relative = true }))
hl.bind(subMod .. " + w",     hl.dsp.window.resize({ x = 0,   y = -80, relative = true }))
-- hjkl
hl.bind(subMod .. " + h",     hl.dsp.window.resize({ x = -80, y = 0,   relative = true }))
hl.bind(subMod .. " + l",     hl.dsp.window.resize({ x = 80,  y = 0,   relative = true }))
hl.bind(subMod .. " + j",     hl.dsp.window.resize({ x = 0,   y = 80,  relative = true }))
hl.bind(subMod .. " + k",     hl.dsp.window.resize({ x = 0,   y = -80, relative = true }))
-- Mouse drag to resize
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize())

-- SPECIAL WORKSPACE
-- ──────────────
hl.bind(mainMod .. " + x",    hl.dsp.workspace.toggle_special("magic"))
hl.bind(moveMod .. " + x",    hl.dsp.window.move({ workspace = "special:magic" }))

-- MULTIMEDIA
-- ──────────────
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { repeating = true })
-- Playerctl (locked -> works on lockscreen)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"),  { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),    { locked = true })
-- Mic toggle
hl.bind("F10",            hl.dsp.exec_cmd("~/.config/hypr/bin/toggle-mic-mute.sh"))
