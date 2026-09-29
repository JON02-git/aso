#!/bin/bash
pedir_puerto_valido() {
    while true
    do
        read -p "Puerto: " puerto

        if [[ $puerto =~ ^[0-9]+$ ]] && (( puerto >= 1 && puerto <= 65535 ))
        then
            break
        fi

        echo "Puerto no válido"
    done
}

pedir_puerto_valido
echo "Puerto válido recibido: $puerto"