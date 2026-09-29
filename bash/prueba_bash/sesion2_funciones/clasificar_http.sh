#!/bin/bash

clasificar_http() {
    codigo=$1

    if [[ $codigo -ge 200 && $codigo -le 299 ]]; then
        echo "Éxito"
    elif [[ $codigo -ge 300 && $codigo -le 399 ]]; then
        echo "Redirección"
    elif [[ $codigo -ge 400 && $codigo -le 499 ]]; then
        echo "Error del cliente"
    elif [[ $codigo -ge 500 && $codigo -le 599 ]]; then
        echo "Error del servidor"
    fi
}

clasificar_http "$1"