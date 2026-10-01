#!/bin/bash

while true; do
    read -p "Introduce tu login: " login
    if [[ $login =~ ^[a-z][a-z0-9]*$ ]]; then
        echo "Login válido"
        if grep -q ^$login: /etc/passwd; then
            echo "El login ya existe en el sistema."
        else
            echo "El login no existe en el sistema."
            echo "Si quieres crear el usuario, ejecuta el siguiente comando: sudo useradd -m -s /bin/bash $login"
        fi
        break
    else
        echo "Login inválido. Debe comenzar con una letra minúscula y seguido de minúsculas y números."
    fi
done