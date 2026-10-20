#!/bin/bash
mostrar_error() {
    echo "Error: $1"
    echo "Uso: ./gestion_usuarios.sh alta | baja identificador"
    exit 1
}

crear_identificador() {
    nombre="$1"
    apellidos="$2"

    nombre=$(echo "$nombre" | tr 'A-Z' 'a-z')
    apellidos=$(echo "$apellidos" | tr 'A-Z' 'a-z')

    apellido1=$(echo "$apellidos" | cut -d' ' -f1)
    apellido2=$(echo "$apellidos" | cut -d' ' -f2)

    letras_nombre=$(echo "$nombre" | cut -c1-2)
    letras_apellido1=$(echo "$apellido1" | cut -c1-2)
    letra_apellido2=$(echo "$apellido2" | cut -c1)

    echo "alu$letras_nombre$letras_apellido1$letra_apellido2"
}

if [ -z "$1" ]; then
    mostrar_error "falta la acción"
fi

accion="$1"

if [ "$accion" != "alta" ] && [ "$accion" != "baja" ]; then
    mostrar_error "la acción $accion no es válida"
fi

if [ "$accion" = "alta" ]; then

    read -p "Nombre: " nombre
    read -p "Apellidos: " apellidos

    if ! [[ "$nombre" =~ ^[a-zA-Z]+$ ]]; then
        mostrar_error "el nombre debe ser una sola palabra con letras"
    fi

    if ! [[ "$apellidos" =~ ^[a-zA-Z]+[[:space:]]+[a-zA-Z]+$ ]]; then
        mostrar_error "escribe los dos apellidos separados por un espacio"
    fi

    identificador=$(crear_identificador "$nombre" "$apellidos")

    echo "Identificador generado: $identificador"

    if id "$identificador" &> /dev/null; then
        mostrar_error "el usuario $identificador ya existe"
    fi

    echo "Para crearlo: sudo useradd -m -s /bin/bash -c \"$nombre $apellidos\" $identificador"

else

    if [ -z "$2" ]; then
        mostrar_error "falta el identificador"
    fi

    identificador="$2"

    if ! [[ "$identificador" =~ ^alu[a-z]{5}$ ]]; then
        mostrar_error "$identificador no tiene el formato aluXXYYZ"
    fi

    if ! id "$identificador" &> /dev/null; then
        mostrar_error "el usuario $identificador no existe"
    fi

    echo "Para eliminarlo: sudo userdel -r $identificador"
fi