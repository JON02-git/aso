#!/bin/bash

if [ "$#" -eq 0 ]; then
    echo "Uso: $0 <numero_puerto>"
    exit 1
fi

puerto="$1"

if ! [[ "$puerto" =~ ^[0-9]+$ ]]; then
    echo "$puerto no es un número"
    exit 1
fi

if [ "$puerto" -lt 1 ] || [ "$puerto" -gt 65535 ]; then
    echo "$puerto está fuera de rango (1-65535)"
    exit 1
fi

echo "$puerto es un puerto válido"