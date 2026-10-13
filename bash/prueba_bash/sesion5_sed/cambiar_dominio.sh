#!/bin/sh
if [ "$#" -eq 0 ]; then
  echo "Uso: $0 fichero" 1>&2
  exit 1
fi

archivo=$1

if [ ! -e "$archivo" ]; then
  echo "Error: fichero '$archivo' no existe" 1>&2
  exit 1
fi

sed -i 's/gmail.com/alu.edu.gav.es/g; s/hotmail.com/alu.edu.gav.es/g' $archivo
cat $archivo