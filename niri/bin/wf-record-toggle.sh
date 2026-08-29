#!/bin/bash
# Toggle Script for wf-recorder

PID_FILE="/tmp/wf-record.pid"
FLAG_FILE="/tmp/.wf-recording"
OUTPUT_FILE="$HOME/Pictures/Captures/$(date +'%Y-%m-%d_%H-%M').mp4"

if [[ -f "$PID_FILE" ]]; then
    # wf-recorder is running, so stop it
    kill "$(cat "$PID_FILE")"
    rm "$PID_FILE"
    rm -f "$FLAG_FILE"
    
    notify-send \
        "Recording Stopped" \
        "Saved to Screenshots folder." \
        -a "Captures" \
        -i media-playback-stop-symbolic
else
    # Start wf-recorder
    wf-recorder -r 30\
        -g "$(slurp)" \
        -f "$OUTPUT_FILE" \
        & echo $! > "$PID_FILE"
    touch "$FLAG_FILE"     

    notify-send \
        "Screen Recording" \
        "Recording started..." \
        -a "Captures" \
        -i media-record-symbolic \
        -u critical
fi
