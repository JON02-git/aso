if [ "$#" -eq 0 ]; then
  echo "Uso: $0 fichero" 1>&2
  exit 1
fi

archivo=$1

if [ ! -e "$archivo" ]; then
  echo "Error: fichero '$archivo' no existe" 1>&2
  exit 1
fi

cp $archivo $archivo.anonimo
sed -i 's/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/XXX.XXX.XXX.XXX/g' $archivo.anonimo
cat $archivo.anonimo