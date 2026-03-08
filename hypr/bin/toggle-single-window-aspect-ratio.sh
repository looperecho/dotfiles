#! /bin/bash
# Toggles between single window aspect ratio and regular full screen single window

if hyprctl -j getoption layout:single_window_aspect_ratio \
   | jq -e '.vec2 == [8,9]'; then
    hyprctl keyword layout:single_window_aspect_ratio 0 0
else
    hyprctl keyword layout:single_window_aspect_ratio 8 9
fi
