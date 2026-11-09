-- Window rules migrated from conf.d/windowrules.conf.
hl.window_rule({ match = { class = "pavucontrol" }, float = true })
hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true })
hl.window_rule({
    match = {
        class = "thunar",
        title = "(Open File|Save File|Select File|Select Folder|ファイルを開く|保存).*",
    },
    float = true,
})
hl.window_rule({ match = { class = "imv" }, float = true })
hl.window_rule({ match = { class = "mpv" }, float = true })
hl.window_rule({
    match = { class = "xdg-desktop-portal-gtk" },
    float = true,
    center = true,
})

hl.window_rule({ match = { class = "com.mitchellh.ghostty" }, opacity = "1.0" })
hl.window_rule({ match = { workspace = "special:quake" }, opacity = "0.9" })
hl.window_rule({ match = { class = "vesktop" }, workspace = "special:discord" })
