#!/bin/bash
nombre=$1
if [ $nombre = "" ]
then
  echo "escribe un nombre"
else
  echo "Bienvenido/a "$nombre
fi
