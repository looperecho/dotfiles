#!/bin/bash

DEFAULT_SOURCE=$(pactl get-default-source)

# looping this as waybar polling of 1 is not fast enough
while true; do
    MUTED=$(pactl get-source-mute "$DEFAULT_SOURCE" | awk '{print $2}')
    if [ "$MUTED" = "yes" ]; then
        echo '{"text": "", "class": "muted", "alt": "muted"}'
        sleep 1
        continue
    fi
    
    # check if apps are accessing audio
    RECORDING_APPS=$(pactl list source-outputs | grep -E "application.name" | \
        grep -v "pw-record" | \
        grep -v "pw-cat")
    
    if [ -z "$RECORDING_APPS" ]; then
        echo '{"text": "", "class": "unused", "alt": "unused"}'
        sleep 2
        continue
    else
        # using pw-record to check for voice activity
        ACTIVITY=$(timeout 0.05 pw-record --target="$DEFAULT_SOURCE" - 2>/dev/null | \
            head -c 2048 | \
            od -An -td1 | \
            awk '{
                for(i=1; i<=NF; i++) {
                    sum += ($i * $i)
                }
            } 
            END {
                print (sum > 500000) ? 1 : 0
            }')

        if [ "${ACTIVITY:-0}" = "1" ]; then
            echo '{"text": "", "class": "active", "alt": "active"}'
        else
            echo '{"text": "", "class": "silent", "alt": "silent"}'
        fi
    fi 
    sleep 0.2
done
