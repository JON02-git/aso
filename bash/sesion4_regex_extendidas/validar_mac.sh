#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_mac>"
    exit 1
fi

mac="$1"


if [[ "$mac" =~ ^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$|^([0-9a-fA-F]{2}-){5}[0-9a-fA-F]{2}$ ]]; then
    echo "$mac es una MAC válida"
else
    echo "$mac no es una MAC válida"
fi