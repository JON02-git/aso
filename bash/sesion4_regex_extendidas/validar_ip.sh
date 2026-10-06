#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_ip>"
    exit 1
fi

ip="$1"

if [[ "$ip" =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
    echo "$ip tiene formato de IP"
else
    echo "$ip no tiene formato de IP"
fi