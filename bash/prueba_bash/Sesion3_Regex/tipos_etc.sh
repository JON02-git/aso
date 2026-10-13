#!/bin/bash
re1='\.conf$'
re2='\.bak$'
conf=0
copias=0

for fichero in /etc/*; do
    if [[ $fichero =~ $re1 ]]; then
        conf=$((conf + 1))
        echo "Archivo de configuración: $fichero"
    elif [[ $fichero =~ $re2 ]]; then
        copias=$((copias + 1))
        echo "Archivo de respaldo: $fichero"
    fi
done

echo "Número de archivos de configuración: $conf"
echo "Número de archivos de respaldo: $copias"