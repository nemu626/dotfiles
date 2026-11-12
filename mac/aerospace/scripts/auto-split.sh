#!/bin/bash
# Hyprland dwindle-like auto split for AeroSpace
# Automatically sets split direction based on focused window's aspect ratio

# Get focused window info
window_info=$(aerospace list-windows --focused --format '%{window-id}' 2>/dev/null)

if [ -z "$window_info" ]; then
    exit 0
fi

# Get window bounds using accessibility API via osascript
read -r width height <<< $(osascript -e '
tell application "System Events"
    set frontApp to first application process whose frontmost is true
    tell frontApp
        set win to first window
        set winSize to size of win
        return (item 1 of winSize) & " " & (item 2 of winSize)
    end tell
end tell
' 2>/dev/null)

if [ -z "$width" ] || [ -z "$height" ]; then
    exit 0
fi

# If window is wider than tall, split vertically (new window goes below)
# If window is taller than wide, split horizontally (new window goes right)
if [ "$width" -gt "$height" ]; then
    aerospace split vertical 2>/dev/null
else
    aerospace split horizontal 2>/dev/null
fi
