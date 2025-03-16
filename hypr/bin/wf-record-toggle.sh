#!/bin/bash
# Toggle Script for wf-recorder

PID_FILE="/tmp/wf-record.pid"
OUTPUT_FILE="$HOME/Pictures/Captures/$(date +'%Y-%m-%d_%H-%M').mp4"

if [[ -f "$PID_FILE" ]]; then
    # wf-recorder is running, so stop it
    kill "$(cat "$PID_FILE")"
    rm "$PID_FILE"
    
    notify-send \
        "Recording Stopped" \
        "Saved to Screenshots folder." \
        -i media-playback-stop-symbolic
else
    # Start wf-recorder
    wf-recorder \
        -g "$(slurp)" \
        -f "$OUTPUT_FILE" \
        & echo $! > "$PID_FILE"
    
    notify-send \
        "Screen Recording" \
        "Recording started..." \
        -i media-record-symbolic \
        -u critical
fi
