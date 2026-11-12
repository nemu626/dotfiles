#!/bin/bash
# Toggle space with focus on current display
# Usage: toggle-space.sh <space_number>

TARGET_SPACE=$1
CURRENT_SPACE=$(yabai -m query --spaces --space | jq -r '.index')
CURRENT_DISPLAY=$(yabai -m query --displays --display | jq -r '.index')

if [ "$CURRENT_SPACE" = "$TARGET_SPACE" ]; then
    # Already on target space, go back to recent
    yabai -m space --focus recent
else
    # Move target space to current display and focus it
    yabai -m space "$TARGET_SPACE" --display "$CURRENT_DISPLAY" 2>/dev/null
    yabai -m space --focus "$TARGET_SPACE"
fi
