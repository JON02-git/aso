#!/bin/bash

DICCIONARIO="/usr/share/dict/spanish"

if [ $# -eq 0 ]; then
    echo "Uso: $0 '<contraseña>'"
    echo "Si la contraseña tiene símbolos, escríbela entre comillas simples."
    exit 1
fi

pass="$1"
segura=1

if [[ "$pass" =~ ^.{12,}$ ]]; then
    echo "Tiene al menos 12 caracteres: sí"
else
    echo "Tiene al menos 12 caracteres: no"
    segura=0
fi

if [[ "$pass" =~ [0-9] ]]; then
    echo "Contiene algún dígito: sí"
else
    echo "Contiene algún dígito: no"
    segura=0
fi

if [[ "$pass" =~ [[:upper:]] ]]; then
    echo "Contiene alguna mayúscula: sí"
else
    echo "Contiene alguna mayúscula: no"
    segura=0
fi

if [[ "$pass" =~ [^[:alnum:]] ]]; then
    echo "Contiene algún símbolo: sí"
else
    echo "Contiene algún símbolo: no"
    segura=0
fi

if [ ! -r "$DICCIONARIO" ]; then
    echo "Aviso: no se puede leer $DICCIONARIO" >&2
fi
if grep -qixF -e "$pass" "$DICCIONARIO" 2>/dev/null; then
    echo "No es una palabra del diccionario: no"
    segura=0
else
    echo "No es una palabra del diccionario: sí"
fi

if [ "$segura" -eq 1 ]; then
    echo "La contraseña es segura"
else
    echo "La contraseña no es segura"
fi