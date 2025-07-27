#!/bin/bash 

if nmcli connection show | grep -qi 'wireguard\s\+--'; then 
    echo '{"text": "", "class": "disconnected", "alt": "vpn_off"}'
else 
    echo '{"text": "", "class": "connected", "alt": "vpn_on"}'
fi
