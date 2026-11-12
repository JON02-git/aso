#!/bin/bash

error(){
    echo "ERROR, Uso: ./$0 <ruta carpeta remota a copiar>"
}

fecha=$(date +%F_%H-%M)

comprobacion=$(ssh -o BatchMode=yes servidor true)

copia=$1

if (($# != 1)); then

    error
    exit 1
fi


if $comprobacion; then

    mkdir -p ~/backups

    rsync -av servidor:"$copia" ~/backups/"$copia"_$fecha
    
    ls ~/backups/

    echo "$copia$fecha Se ha copiado correctamente" > ~/backups/backup.log

else
    echo "Error de conexión con el servidor"
    error
    exit 1
fi