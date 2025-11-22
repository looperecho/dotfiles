#! /bin/bash

MIC_SOURCE=$(pactl info | grep "Default Source" | cut -d: -f2 | xargs)

function check_mute {
    mute_state=$(pactl get-source-mute "$MIC_SOURCE")
    if [ "$mute_state" = "Mute: yes" ]; then
        mic_status="Muted"
        mic_icon="audio-input-microphone-muted"
    else
        mic_status="Live"
        mic_icon="microphone"
    fi
}

function toggle_mute {
    if [ "$MIC_SOURCE" ]; then
        pactl set-source-mute $MIC_SOURCE "toggle"
    fi
}

function notify {
    notify-send \
        -i $mic_icon \
        -u low \
        "Mic Input" \
        "$mic_status"
}

toggle_mute
check_mute
notify
