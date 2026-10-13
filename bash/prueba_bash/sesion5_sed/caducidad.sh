#!/bin/sh
if [ "$#" -eq 0 ]; then
  echo "Uso: $0 numero de dias" 1>&2
  exit 1
fi
dias=$1
archivo="lab-sed/login.defs"
if [ ! -e "$archivo" ]; then
  echo "Error: fichero '$archivo' no existe" 1>&2
  exit 1
fi

sed -i.bak "s/^PASS_MAX_DAYS.*/PASS_MAX_DAYS $dias/" $archivo
cat $archivo