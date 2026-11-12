#!/bin/bash
# Toggle slack workspace with summon behavior
# If already on slack -> go back to previous workspace
# Otherwise -> summon slack to current monitor

current=$(aerospace list-workspaces --focused)

if [ "$current" = "slack" ]; then
    aerospace workspace-back-and-forth
else
    aerospace summon-workspace slack
fi
