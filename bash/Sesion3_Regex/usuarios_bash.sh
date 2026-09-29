#!/bin/bash
contador=0
while read -r linea; do
    if [[ $linea == ${linea%%:bash} ]]; then
        echo "${linea%%:*}"
        contador=$((contador + 1))
    fi
done < /etc/passwd
echo "Número de usuarios: $contador"