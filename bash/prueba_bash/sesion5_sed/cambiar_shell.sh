#!/bin/bash
if [ $# -ne 2 ]; then
    echo "Uso: $0 usuario shell"
    echo "Ejemplo: $0 ubuntu /bin/zsh"
    exit 1
fi

usuario=$1
shell=$2
fichero="passwd"
if [ ! -f "$fichero" ]; then
    echo "Error: no existe el fichero $fichero"
    exit 1
fi

if ! grep -q "^$usuario:" "$fichero"; then
    echo "Error: el usuario $usuario no existe"
    exit 1
fi

if ! echo "$shell" | grep -qE "^/bin/(bash|sh|zsh)$"; then
    echo "Error: la shell debe ser /bin/bash, /bin/sh o /bin/zsh"
    exit 1
fi

sed -i.bak "s|^\($usuario:[^:]*:[^:]*:[^:]*:[^:]*:[^:]*:\).*|\1$shell|" "$fichero"
grep "^$usuario:" "$fichero"