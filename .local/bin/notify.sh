#!/bin/bash
message="$1"
paplay ~/.config/dunst/Metal-pipe-falling-sound-effect.mp3 &
notify-send "$message"
uair -q
sleep 2
uairctl next
uairctl toggle
