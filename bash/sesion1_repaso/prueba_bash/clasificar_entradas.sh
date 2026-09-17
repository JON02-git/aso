#!/bin/bash

for entradas in ./*; do
    if [[ -d $entradas ]]; then
        echo $entradas "directorio"
    else
        echo $entradas "archivo"
    fi
done