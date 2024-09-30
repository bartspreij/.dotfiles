#!/bin/bash
message="$1"
paplay ~/.local/share/sounds/Metal-pipe-falling-sound-effect.mp3 &
notify-send "$message" -i ~/.local/share/icons/pomodoro-technique.png
