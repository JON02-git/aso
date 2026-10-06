#!/bin/bash

if [ $# -eq 0 ]; then
    echo "Uso: $0 <direccion_correo>"
    exit 1
fi

correo="$1"

if [[ "$correo" =~ ^[a-z0-9._-]+@(alu\.)?edu\.gva\.es$ ]]; then
    if [ -n "${BASH_REMATCH[1]}" ]; then
        echo "$correo es una cuenta de alumno"
    else
        echo "$correo es una cuenta de profesores"
    fi
else
    echo "$correo no es una cuenta educativa"
fi