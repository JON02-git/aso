#!/bin/bash

if [ -z "$1" ]; then
    echo "Debes indicar el nombre del servicio"
else
    echo "Iniciando el servicio $1..."
fi