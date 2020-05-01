#!/bin/bash
#En esta variable ponemos nuestro dominio educativo (incluyendo la @)
DOMINIO="@midominio.com"
#Unimos los .csv de los distintos cursos que haya en la carpeta (regAlum de Séneca)
cat *.csv > ficheros-unidos.csv
#Insertamos \n porque de lo contrario no lee el último alumno
echo '\n' >> ficheros-unidos.csv
#Escribimos la contraseña que deseamos que tengan todas las nuevas cuentas creadas
echo 'Introduzca la contraseña que desea asignar a las cuentas:'
read password
#Escribimos si deseamos o no forzar un cambio de contraseña al primer inicio de sesión
echo "¿Quieres forzar el cambio de contraseña cuando inicien sesión? (Escribe 1 o 2)"
select yn in "Sí" "No"; do
    case $yn in
        Sí ) force=on; break;;
        No ) force=off; break;;
    esac
done
#Convertimos el fichero al formato UTF-8
iconv -f "ISO8859-1" -t "UTF-8" ficheros-unidos.csv > ficheros-unidos-utf8.csv
IFS=,
while read apellidos nombre resto;
do
	echo "nombre: ${nombre/\"/}"
	echo "apellidos: ${apellidos/\"/}"
	#El email estará formado por el nombre y dos apellidos seguidos
	email=$(echo "${nombre/\"/}${apellidos/\"/}"$DOMINIO | tr '[:upper:]' '[:lower:]' | tr -d '[[:space:]]' | tr "áéíóúñü" "aeiounu")
	echo "email: $email"
	#En la siguiente línea puedes añadir org NombreUnidadOrganizativa para añadir los usuarios a una unidad organizativa concreta
	./gam create user $email firstname "${nombre/\"/}" lastname "${apellidos/\"/}" password $password changepassword $force
done < ficheros-unidos-utf8.csv
#Eliminamos los ficheros auxiliares utilizados
rm ficheros-unidos.csv
rm ficheros-unidos-utf8.csv
