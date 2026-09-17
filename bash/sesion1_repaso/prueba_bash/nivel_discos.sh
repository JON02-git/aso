#!/bin/bash

if [ -z "$1" ]  && [ -z "$2" ]; then
    echo "Debes pasar por parametro los bytes usados y los bytes totales de un disco"
else
    porcentaje=$(($1 * 100 / $2))
    if [ $porcentaje -lt 70 ]; then
        echo "OK"
    elif [ $porcentaje -ge 70 ] && [ $porcentaje -lt 90 ]; then
        echo "AVISO"
    else
        echo "CRÍTICO"
    fi
fi