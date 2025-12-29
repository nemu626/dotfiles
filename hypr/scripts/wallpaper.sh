#!/bin/bash
# Wallpaper management script using swww

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

case "$1" in
    "set")
        # Set specific wallpaper
        if [[ -f "$2" ]]; then
            swww img "$2" --transition-type grow --transition-pos center --transition-duration 1
        else
            echo "File not found: $2"
            exit 1
        fi
        ;;
    "random")
        # Random wallpaper from directory
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | shuf -n 1)
        if [[ -n "$WALLPAPER" ]]; then
            swww img "$WALLPAPER" --transition-type grow --transition-pos center --transition-duration 1
            notify-send "Wallpaper" "Changed to $(basename "$WALLPAPER")"
        else
            echo "No wallpapers found in $WALLPAPER_DIR"
            exit 1
        fi
        ;;
    "select")
        # Select wallpaper using rofi
        WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | rofi -dmenu -p "Select Wallpaper")
        if [[ -n "$WALLPAPER" ]]; then
            swww img "$WALLPAPER" --transition-type grow --transition-pos center --transition-duration 1
        fi
        ;;
    *)
        echo "Usage: $0 {set <path>|random|select}"
        exit 1
        ;;
esac
