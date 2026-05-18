-- Auto-start Processes

hl.on("hyprland.start", function()

    -- Core
    -- ──────────────
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("dbus-update-activation-environment --systemd --all")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Sys Utils
    -- ──────────────
    hl.exec_cmd("waybar &")
    hl.exec_cmd("hyprpaper &")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("swaync &")
    hl.exec_cmd("export IBUS_NO_SNOOPER=1 && nohup ibus-daemon -drx >/dev/null 2>&1 &")
    hl.exec_cmd("~/.config/hypr/bin/language_status.sh")

    -- Apps
    -- ──────────────
    hl.exec_cmd("gapplication launch io.ulauncher.Ulauncher")
    hl.exec_cmd("ulauncher-toggle &")
end)
