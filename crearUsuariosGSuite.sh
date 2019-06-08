#!/bin/bash
cat *.csv > ficheros-unidos.csv
echo 'Introduzca la contraseña que desea asignar a las cuentas:'
read password
iconv -f "windows-1252" -t "UTF-8" ficheros-unidos.csv > ficheros-unidos-utf8.csv
IFS=,
while read apellidos nombre resto
do
	echo "nombre: ${nombre/\"/}"
	echo "apellidos: ${apellidos/\"/}"
	email=$(echo "${nombre/\"/}${apellidos/\"/}""@lasallemundonuevo.es" | tr '[:upper:]' '[:lower:]' | tr -d '[[:space:]]' | tr "áéíóúñ" "aeioun")
	echo "email: $email"
	/Users/david/bin/gam/gam create user $email firstname "${nombre/\"/}" lastname "${apellidos/\"/}" password $password
done < ficheros-unidos-utf8.csv