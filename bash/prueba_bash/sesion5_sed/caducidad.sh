#!/bin/sh
if [ "$#" -eq 0 ]; then
  echo "Uso: $0 numero de dias" 1>&2
  exit 1
fi

if ! [[ "$1" =~ ^[0-9]+$ ]] || [ "$1" -lt 1 ]; then
  echo "Error: introduce un numero entero del 1 en adelante" >&2
  exit 1
fi

dias=$1
archivo="lab-sed/login.defs"
if [ ! -e "$archivo" ]; then
  echo "Error: fichero '$archivo' no existe" 1>&2
  exit 1
fi
antes=$(grep '^PASS_MAX_DAYS' "$archivo")
sed -i.bak "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $dias/" $archivo
despues=$(grep '^PASS_MAX_DAYS' "$archivo")

echo "Antes: $antes"
echo "Después: $despues"