#!/bin/bash

listar_usuarios() {
    echo "Ingrese el nombre de usuario:"
    read -r usuario
    if (! id "$usuario" &>/dev/null); then
        echo "El usuario $usuario no existe"
        return 1
    fi
    ps -u $usuario -o pid,stat,%cpu,%mem,cmd
}
buscar_proceso() {
    echo "Ingrese el nombre del proceso:"
    read -r proceso
    if (ps -C "$proceso" > /dev/null 2>&1); then
        echo "No se encontró el proceso $proceso"
        return 1
    fi
    ps -C "$proceso" -o pid,user,%cpu,cmd
}
top_cpu() {
    echo "Ingrese el número de procesos a mostrar (por defecto 5): "
    read -r n
    n=${1:-5}
    ps aux --sort=-%cpu | head -n "$((n+1))"
}
cambiar_prioridad() {
    echo "Ingrese el PID del proceso:"
    read -r pid
    echo "Ingrese la nueva prioridad (valor entre -20 y 19): "
    read -r prioridad

    if ! validar_pid "$pid"; then
        echo "Error: PID no válido o proceso inexistente"
        return 1
    fi

    if [ "$prioridad" -lt -20 ] || [ "$prioridad" -gt 19 ]; then
        echo "Error: el valor debe estar entre -20 y 19"
        return 1
    fi

    if [[ $EUID -ne 0 ]] && [ "$prioridad" -lt 0 ]; then
        echo "Error: necesitas ser root para usar valores negativos"
        return 1
    fi

    renice -n "$prioridad" -p "$pid"
    comando=$(ps -p "$pid" -o comm=)
    echo "$(date '+%Y-%m-%d %H:%M:%S') - cambio de prioridad - $pid - $comando" >> ~/gestion_procesos.log
}
finalizar_proceso() {
    echo "Ingrese el PID del proceso:"
    read -r pid
    
    if ! validar_pid "$pid"; then
        echo "Error: PID no válido o proceso inexistente"
        return 1
    fi
    
    echo "¿Seguro que quieres finalizar el proceso $pid? (s/n)"
    read -r confirmacion
    if [[ "$confirmacion" != "s" ]]; then
        echo "Finalización de proceso cancelada"
        return 1
    fi

    comando=$(ps -p "$pid" -o comm=)
    kill -TERM "$pid"
    sleep 3

    if ps -p "$pid" > /dev/null; then
        kill -KILL "$pid"
        echo "Proceso $pid finalizado con SIGKILL"
    else
        echo "Proceso $pid finalizado con SIGTERM"
    fi
    echo "$(date '+%Y-%m-%d %H:%M:%S') - proceso finalizado - $pid - $comando" >> ~/gestion_procesos.log
}

validar_pid() {
    if [[ "$1" =~ ^[0-9]+$ ]] && ps -p "$1" > /dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}

while ! [[ "$option" == 6 ]]; do
    echo "===== GESTIÓN DE PROCESOS ====="
    echo "1) Listar los procesos de un usuario"
    echo "2) Buscar un proceso por nombre"
    echo "3) Mostrar los N procesos que más CPU consumen"
    echo "4) Cambiar la prioridad de un proceso"
    echo "5) Finalizar un proceso"
    echo "6) Salir"
    echo "Seleccione una opción (1-6):"
    read -r option
    case $option in
        1)
            listar_usuarios
            ;;
        2)
            buscar_proceso
            ;;
        3)
            top_cpu
            ;;
        4)
            cambiar_prioridad
            ;;
        5)
            finalizar_proceso
            ;;
        6)
            echo "Adiós !"
            sleep 3
            clear
            exit 0
            ;;
        *)
            echo "Opción no válida"
            sleep 2
            clear
            ;;
    esac
done