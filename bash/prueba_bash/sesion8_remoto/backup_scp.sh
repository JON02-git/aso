#!/bin/bash

if [ -z "$1" ]; then
    echo "Uso: $0 <ruta_destino>"
    exit 1
fi

CARPETA="$1"
FECHA=$(date +%F_%H-%M)
DESTINO="$HOME/backups/datos_$FECHA"

mkdir -p "$HOME/backups"

ssh -o BatchMode=yes servidor true
if [ $? -ne 0 ]; then
    echo "Error: no hay conexión con el servidor"
    echo "$(date) $CARPETA ERROR" >> "$HOME/backups/backup.log"
    exit 1
fi

scp -r servidor:"$CARPETA" "$DESTINO"

if [ $? -eq 0 ]; then
    echo "$(date) $CARPETA OK" >> "$HOME/backups/backup.log"
    echo "Copia realizada en $DESTINO"
else
    echo "$(date) $CARPETA ERROR" >> "$HOME/backups/backup.log"
    echo "Error al copiar"
    exit 1
fi