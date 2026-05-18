-- Environment Variables

-- Base
-- ──────────────
hl.env("XDG_SESSION_TYPE",    "wayland")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")

hl.env("GDK_BACKEND",    "wayland")
hl.env("CLUTTER_BACKEND","wayland")
hl.env("SDL_VIDEODRIVER", "x11")
hl.env("GDK_GL",         "gles")

hl.env("XCURSOR_SIZE",    "24")
hl.env("XCURSOR_THEME",   "Notwaita-Gray")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("QT_QPA_PLATFORM",               "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME",          "qt5ct")
hl.env("QT_STYLE_OVERRIDE",             "kvantum")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_SCALE_FACTOR",               "1.25")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",   "1")

hl.env("MOZ_ENABLE_WAYLAND", "1")

-- NVIDIA
-- ──────────────
hl.env("LIBVA_DRIVER_NAME",      "nvidia")
hl.env("GBM_BACKEND",            "nvidia-drm")
hl.env("__GLX_VENDOR_LIBRARY_NAME", "nvidia")

hl.config({
    cursor = {
        no_hardware_cursors = true,
    }
})
