#!/bin/bash

if [ "$1" = "" ]; then
    fichero="/etc/login.defs"
else
    fichero="$1"
fi

if [ ! -f "$fichero" ]; then
    echo "Error: El fichero $fichero no existe."
    exit 1
fi
grep -v -e "^#" -e "^$" "$fichero"