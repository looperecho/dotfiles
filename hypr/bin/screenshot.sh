#!/bin/bash
#
# Screenshot with grim, slurp and swappy
#

file_path="$HOME/Pictures/Screenshots/$(date +"%Y-%m-%d_%H-%M").png"
file_name=$(basename ${file_path})

# Function to notify after swappy
swappy_notify() {
    if [ -f $file_path ]; then
        notify-send -u normal \
            -a "Captures" \
            -i $file_path \
            "Screenshot" \
            "Saved as: \n$file_name"

    elif [ $(wl-paste -l) == "image/png" ]; then
        notify-send -u low \
            -a "Captures" \
            -i desktop-symbolic \
            -h boolean:transient:true \
            "Screenshot" \
            "Copied to clipboard"
    fi
}

# Screenshot action
grim -g "$(slurp -d)" - | swappy -f - && swappy_notify
