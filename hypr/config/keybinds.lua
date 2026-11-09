-- Key bindings migrated from conf.d/keybinds.conf.
local main = "SUPER"
local terminal = "ghostty"
local file_manager = "thunar"
local web_browser = "firefox"
local sub_browser = "google-chrome"

-- Applications.
hl.bind(main .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(main .. " + T", hl.dsp.exec_cmd(terminal))
hl.bind(main .. " + E", hl.dsp.exec_cmd(file_manager))
hl.bind(main .. " + B", hl.dsp.exec_cmd(web_browser))
hl.bind(main .. " + SHIFT + B", hl.dsp.exec_cmd(sub_browser))
hl.bind(main .. " + SHIFT + code:201", hl.dsp.exec_cmd("gtk-launch WebApp-ChatGPT1848.desktop"))
hl.bind(main .. " + SHIFT + ALT + code:201", hl.dsp.exec_cmd("gtk-launch WebApp-Gemini8043.desktop"))

-- Window management.
hl.bind("ALT + F4", hl.dsp.window.close())
for _, key in ipairs({ "Q", "W", "C" }) do
    hl.bind(main .. " + " .. key, hl.dsp.window.close())
end
hl.bind(main .. " + F", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(main .. " + SHIFT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind(main .. " + P", hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(main .. " + Z", hl.dsp.layout("togglesplit"))

-- DMS launchers and overview. Hyprexpo was replaced because hyprpm is no
-- longer installed; DMS provides the equivalent overview UI.
hl.bind(main .. " + SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("ALT + SPACE", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind(main .. " + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind("ALT + TAB", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
hl.bind(main .. " + comma", hl.dsp.exec_cmd("dms ipc call processlist focusOrToggle"))
hl.bind(main .. " + ALT + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("Print", hl.dsp.exec_cmd("dms screenshot full"))
hl.bind(main .. " + Print", hl.dsp.exec_cmd("dms screenshot"))
hl.bind(main .. " + SHIFT + Print", hl.dsp.exec_cmd("dms screenshot --no-file"))
hl.bind(main .. " + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))

-- Special workspaces.
hl.bind("ALT + grave", hl.dsp.workspace.toggle_special("quake"))
hl.bind(main .. " + grave", hl.dsp.workspace.toggle_special("quake"))
hl.bind(main .. " + D", hl.dsp.workspace.toggle_special("discord"))
hl.bind(main .. " + SHIFT + D", hl.dsp.window.move({ workspace = "special:discord", follow = true }))

-- Focus and window movement.
local directions = {
    h = "left",
    l = "right",
    k = "up",
    j = "down",
    left = "left",
    right = "right",
    up = "up",
    down = "down",
}
for key, direction in pairs(directions) do
    hl.bind(main .. " + " .. key, hl.dsp.focus({ direction = direction }))
    hl.bind(main .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

local resize = {
    h = { -50, 0 },
    l = { 50, 0 },
    k = { 0, -50 },
    j = { 0, 50 },
    left = { -50, 0 },
    right = { 50, 0 },
    up = { 0, -50 },
    down = { 0, 50 },
}
for key, delta in pairs(resize) do
    hl.bind(main .. " + CTRL + " .. key, hl.dsp.window.resize({
        x = delta[1],
        y = delta[2],
        relative = true,
    }))
end

-- Workspaces.
for workspace = 1, 10 do
    local key = workspace % 10
    hl.bind(main .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
    hl.bind(main .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace, follow = true }))
end
hl.bind(main .. " + page_up", hl.dsp.focus({ workspace = "-1" }))
hl.bind(main .. " + page_down", hl.dsp.focus({ workspace = "+1" }))
hl.bind(main .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(main .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(main .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(main .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic", follow = true }))

-- Mouse actions.
hl.bind(main .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(main .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop lid switch.
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/lid-switch.sh close"), { locked = true })
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("~/.config/hypr/scripts/lid-switch.sh open"), { locked = true })

-- Media and brightness keys.
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 3"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 3"), { locked = true, repeating = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

hl.bind(main .. " + SHIFT + O", hl.dsp.exec_cmd([[wf-recorder -g "$(slurp)"]]))
