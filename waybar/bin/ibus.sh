#!/bin/bash

# Show current ibus input method
engine=$(ibus engine)

if [[ $engine == "mozc-on" ]]; then
    echo "JP"
elif [[ $engine = "xkb:us::eng" ]]; then
    echo "EN"
else
    echo "?"
fi
