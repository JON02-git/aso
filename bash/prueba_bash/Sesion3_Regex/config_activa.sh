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

totales=0
utiles=0

while read -r linea
do
    totales=$((totales + 1))
    es_comentario=$(echo "$linea" | grep "^#")

    if [ "$linea" != "" ] && [ "$es_comentario" = "" ]; then
        echo "$linea"
        utiles=$((utiles + 1))
    fi
done < "$fichero"
echo "----"
echo "Líneas totales: $totales"
echo "Líneas útiles: $utiles"

#PASS_MAX_DAYS define el número máximo de días que una contraseña es válida antes de caducar.
#No, no es seguro.