#!/bin/bash
destino="${1:-/home/joagilmas}"
maximo="${2:-7}"

registrar() {
    echo "$(date '+%H:%M:%S') $1"
    logger -t aso-backup "$1"
}

if [ ! -d "$destino" ]; then
    registrar "Error: el directorio $destino no existe"
    exit 1
fi

if ! [[ "$maximo" =~ ^[0-9]+$ ]]; then
    registrar "Error: $maximo no es un número"
    exit 1
fi

if [ "$maximo" -le 0 ]; then
    registrar "Error: el número máximo de copias debe ser mayor que 0"
    exit 1
fi

fecha=$(date '+%Y%m%d-%H%M%S')
archivo="$destino/etc-$fecha.tar.gz"

tar -czf "$archivo" /etc > /dev/null 2>&1

registrar "Copia creada: $archivo"

copias=$(ls "$destino" | grep -c '^etc-[0-9]\{8\}-[0-9]\{6\}\.tar\.gz$')

if [ "$copias" -gt "$maximo" ]; then
    registrar "Aviso: hay $copias copias y el máximo recomendado es $maximo"
fi