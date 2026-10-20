#!/bin/bash
shell="${1:-/bin/bash}"
if ! [[ "$shell" =~ ^(/[a-z]+)+$ ]]; then
    echo "Error: $shell no es una ruta válida"
    exit 1
fi

total=0
mayores=0
while IFS=':' read -r usuario x uid gid desc home shell_usuario; do
    if [ "$shell_usuario" = "$shell" ]; then

        echo "$usuario:$uid:$home:$shell_usuario"

        total=$((total + 1))

        # UID mayor o igual que 1000
        if [ "$uid" -ge 1000 ]; then
            mayores=$((mayores + 1))
        fi
    fi

done < /etc/passwd
echo "----"
echo "Cuentas listadas: $total"
echo "Con UID >= 1000: $mayores"