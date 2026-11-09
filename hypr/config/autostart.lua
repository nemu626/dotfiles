-- Autostart commands migrated from conf.d/autostart.conf.
hl.on("hyprland.start", function()
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    hl.exec_cmd("dunst")
    hl.exec_cmd("swww-daemon && swww img ~/.config/hypr/wallpapers/default.jpg")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets,pkcs11,ssh")
    hl.exec_cmd("hyprpolkitagent")

    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    hl.exec_cmd("dbus-update-activation-environment --all")
    hl.exec_cmd("sleep 1 && /usr/lib/xdg-desktop-portal-hyprland")

    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("ghostty", { workspace = "special:quake silent" })
    hl.exec_cmd("vesktop", { workspace = "special:discord silent" })
    hl.exec_cmd("fcitx5")
end)
