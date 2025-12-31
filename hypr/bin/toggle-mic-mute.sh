#! /bin/bash

MIC_SOURCE=$(pactl info | grep "Default Source" | cut -d: -f2 | xargs)
AUDIO_SOURCE="$HOME/.repo/audio"

function check_mute {
    mute_state=$(pactl get-source-mute "$MIC_SOURCE")
    if [ "$mute_state" = "Mute: yes" ]; then
        mic_status="Muted"
        priority_status="critical"
        mic_icon="audio-input-microphone-muted"
        notify_audio_path="$AUDIO_SOURCE/source-off.wav"
    else
        mic_status="Live"
        priority_status="low"
        mic_icon="microphone"
        notify_audio_path="$AUDIO_SOURCE/source-on.wav"
    fi
}

function toggle_mute {
    if [ "$MIC_SOURCE" ]; then
        pactl set-source-mute $MIC_SOURCE "toggle"
    fi
}

function notify {
    notify-send -u $priority_status \
        -h boolean:transient:true \
        "Mic Input" \
        -i $mic_icon \
        "$mic_status" ; \
    paplay $notify_audio_path
}

toggle_mute
check_mute
notify
