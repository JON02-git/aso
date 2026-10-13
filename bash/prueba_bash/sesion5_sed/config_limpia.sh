#!/bin/sh
if [ "$#" -eq 0 ]; then
  echo "Uso: $0 fichero" 1>&2
  exit 1
fi

FILE=$1

if [ ! -e "$FILE" ]; then
  echo "Error: fichero '$FILE' no existe" 1>&2
  exit 1
fi

sed '/^[[:space:]]*#/d;/^[[:space:]]*$/d' -- "$FILE"
