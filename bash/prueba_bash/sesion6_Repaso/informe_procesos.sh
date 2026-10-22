#!/bin/bash
ps -u "$USER" -o pid,pcpu,pmem,comm --sort=-pcpu > procesos.txt
if [ $# -eq 0 ]; then
    cat procesos.txt
else
    if ! [[ "$1" =~ ^[0-9]+$ ]]; then
        echo "Error: $1 no es un número válido"
        exit 1
    fi

    if [ "$1" -le 0 ]; then
        echo "Error: el número debe ser mayor que 0"
        exit 1
    fi
    head -n "$1" procesos.txt
fi

total=$(($(wc -l < procesos.txt) - 1))
echo "----"
echo "Procesos de $USER: $total"