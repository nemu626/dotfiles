#!/bin/bash
# Volume control script using pamixer

get_volume() {
    pamixer --get-volume
}

is_muted() {
    pamixer --get-mute
}

send_notification() {
    volume=$(get_volume)
    muted=$(is_muted)
    
    if [[ "$muted" == "true" ]]; then
        icon="audio-volume-muted"
        dunstify -a "Volume" -u low -r 9999 -h int:value:0 -i "$icon" "Muted"
    elif [[ $volume -eq 0 ]]; then
        icon="audio-volume-muted"
        dunstify -a "Volume" -u low -r 9999 -h int:value:0 -i "$icon" "Volume: $volume%"
    elif [[ $volume -lt 30 ]]; then
        icon="audio-volume-low"
        dunstify -a "Volume" -u low -r 9999 -h int:value:$volume -i "$icon" "Volume: $volume%"
    elif [[ $volume -lt 70 ]]; then
        icon="audio-volume-medium"
        dunstify -a "Volume" -u low -r 9999 -h int:value:$volume -i "$icon" "Volume: $volume%"
    else
        icon="audio-volume-high"
        dunstify -a "Volume" -u low -r 9999 -h int:value:$volume -i "$icon" "Volume: $volume%"
    fi
}

case "$1" in
    "up")
        pamixer -u
        pamixer -i 5
        send_notification
        ;;
    "down")
        pamixer -u
        pamixer -d 5
        send_notification
        ;;
    "mute")
        pamixer -t
        send_notification
        ;;
    "get")
        echo "$(get_volume)%"
        ;;
    *)
        echo "Usage: $0 {up|down|mute|get}"
        exit 1
        ;;
esac
