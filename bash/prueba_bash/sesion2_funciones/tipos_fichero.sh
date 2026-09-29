#!/bin/bash
contar_por_extension() {
    find "$1" -maxdepth 1 -type f -name "*.$2" | wc -l
}

for ext in log txt csv
do
    echo "$ext: $(contar_por_extension ~/prueba_bash/datos $ext)"
done