#!/bin/bash

if rfkill list bluetooth | grep -q "Soft blocked: no"; then
    echo "true"
else
    echo "false"
fi
