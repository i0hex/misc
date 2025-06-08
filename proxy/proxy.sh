#!/bin/bash

op=${1:-"on"}

if [ "$op" = "on" ]; then
    echo "Proxy ON"
    export http_proxy="socks5h://127.0.0.1:<Your Port>"
    export https_proxy="socks5h://127.0.0.1:<Your Port>"
    export HTTP_PROXY="$http_proxy"
    export HTTPS_PROXY="$https_proxy"
    export ALL_PROXY="$http_proxy"
    
elif [ "$op" = "off" ]; then
    echo "Proxy OFF"
    unset http_proxy
    unset https_proxy
    unset HTTP_PROXY
    unset HTTPS_PROXY
    unset ALL_PROXY

elif [ "$op" = "status" ]; then
	echo -e "Current proxy settings:"
	env | grep -i proxy

else 
    echo "Invalid option. Usage: $0 [on|off]"
    exit 1
fi

