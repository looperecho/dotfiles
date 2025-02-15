#!/bin/bash
# Monitors input language

last_engine=""

while true; do
    current_engine=$(ibus engine)
    
    # Determine display in waybar
    if [[ $current_engine != $last_engine ]]; then
        if [[ $current_engine == "mozc-on" ]]; then
            display="JP"
        elif [[ $current_engine == "xkb:us::eng" ]]; then
            display="EN"
        else
            display="?"
        fi
        
        # Update state file for waybar
        echo "$display" > /tmp/current_input_method
        
        # Send notification
        notify-send -t 2000 \
            -u low \
            -h string:x-canonical-private-synchronous:input-method \
            -h string:desktop-entry:input-method \
            -h boolean:transient:true \
            -i preferences-desktop-keyboard-symbolic \
            "$display" \
            "Switched input method"
        
        # Signal waybar to update
        pkill -RTMIN+1 waybar
        
        last_engine=$current_engine
    fi
    
    sleep 0.5
done
