#!/bin/bash

listar_usuarios() {
    echo "Ingrese el nombre de usuario:"
    read -r usuario
    ps -u $usuario -o pid,stat,%cpu,%mem,cmd
}
buscar_proceso() {
    echo "Ingrese el nombre del proceso:"
    read -r proceso
    ps -C "$proceso" -o pid,user,%cpu,cmd
}
top_cpu() {
    echo "Ingrese el número de procesos a mostrar:"
    read -r n
    n=$((n + 1))
    ps aux --sort=-%cpu | head -n "$n"
}
cambiar_prioridad() {
    echo "Ingrese el PID del proceso:"
    read -r pid
    echo "Ingrese la nueva prioridad (valor entre -20 y 19):"
    read -r prioridad
    renice -n "$prioridad" -p "$pid"
    echo "Prioridad del proceso $pid cambiada a $prioridad"
}
finalizar_proceso() {
    echo "Ingrese el PID del proceso:"
    read -r pid
    kill "$pid"
    echo "Proceso $pid finalizado"
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