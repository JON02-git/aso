#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_ip>"
    exit 1
fi

ip="$1"

if [[ "$ip" =~ ^127\. ]]; then
    echo "$ip es una dirección loopback"
elif [[ "$ip" =~ ^(10\.|192\.168\.|172\.(1[6-9]|2[0-9]|3[01])\.) ]]; then
    echo "$ip es una dirección privada"
# Pública: cualquier otra
else
    echo "$ip es una dirección pública"
fi