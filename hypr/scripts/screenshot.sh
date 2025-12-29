#!/bin/bash
# Screenshot script using grim + slurp

SCREENSHOTS_DIR="$HOME/Pictures/Screenshots"
mkdir -p "$SCREENSHOTS_DIR"

FILENAME="$SCREENSHOTS_DIR/screenshot_$(date +%Y%m%d_%H%M%S).png"

case "$1" in
    "region")
        # Region selection
        grim -g "$(slurp)" "$FILENAME"
        ;;
    "window")
        # Active window
        grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$FILENAME"
        ;;
    "full")
        # Full screen
        grim "$FILENAME"
        ;;
    *)
        # Default: region selection
        grim -g "$(slurp)" "$FILENAME"
        ;;
esac

# Copy to clipboard
if [[ -f "$FILENAME" ]]; then
    wl-copy < "$FILENAME"
    notify-send "Screenshot" "Saved to $FILENAME" -i "$FILENAME"
fi
