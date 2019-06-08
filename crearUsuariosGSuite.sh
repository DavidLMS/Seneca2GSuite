#!/bin/bash
#En esta variable ponemos nuestro dominio educativo (incluyendo la @)
DOMINIO="@lasallemundonuevo.es"
#Unimos los .csv de los distintos cursos que haya en la carpeta (regAlum de Séneca)
cat *.csv > ficheros-unidos.csv
#Insertamos \n porque de lo contrario no lee el último alumno
echo '\n' >> ficheros-unidos.csv
#Escribimos la contraseña que deseamos que tengan todas las nuevas cuentas creadas
echo 'Introduzca la contraseña que desea asignar a las cuentas:'
read password
#Convertimos el fichero al formato UTF-8
iconv -f "windows-1252" -t "UTF-8" ficheros-unidos.csv > ficheros-unidos-utf8.csv
IFS=,
while read apellidos nombre resto;
do
	echo "nombre: ${nombre/\"/}"
	echo "apellidos: ${apellidos/\"/}"
	#El email estará formado por el nombre y dos apellidos seguidos
	email=$(echo "${nombre/\"/}${apellidos/\"/}"$DOMINIO | tr '[:upper:]' '[:lower:]' | tr -d '[[:space:]]' | tr "áéíóúñ" "aeioun")
	echo "email: $email"
	./gam create user $email firstname "${nombre/\"/}" lastname "${apellidos/\"/}" password $password
done < ficheros-unidos-utf8.csv
#Eliminamos los ficheros auxiliares utilizados
rm ficheros-unidos.csv
rm ficheros-unidos-utf8.csv
