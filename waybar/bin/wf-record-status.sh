#!/bin/bash

FLAG_FILE="/tmp/.wf-recording"

if [[ -f "$FLAG_FILE" ]]; then
    echo '{"text": "", "class": "recording", "alt": "recording"}'
else
    :
fi
