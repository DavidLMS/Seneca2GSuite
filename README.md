# Seneca2GSuite
Script realizado en Bash para facilitar la creación de cuentas educativas en G-Suite for Education usando la información de la plataforma Séneca (Andalucía). Concretamente, crea las cuentas que no existan con la contraseña dada siguiendo el formato: nombreapellidos@dominio.com.

## Instalación y uso
Este script requiere la instalación previa de GAM (https://github.com/jay0lee/GAM).

Solamente debes editarlo y cambiar **@midominio.com** por el dominio educativo de tu organización. 

El script creará una cuenta para todos los usuarios (excepto los que ya tengan cuenta) que se encuentren en uno o varios .csv dentro de la misma carpeta del script (los .csv exportados directamente de la plataforma Séneca de la Junta de Andalucía).

En la ejecución se asume que el script y los .csv están en la misma carpeta que GAM, pero puedes simplemente cambiar **./gam** por la ubicación del ejecutable.

Por defecto, los usuarios se añaden a la Unidad Organizativa superior, que tiene el mismo nombre que el dominio. Si quieres añadir los usuarios a una Unidad Organizativa concreta, en la línea siguiente al comentario "#En la siguiente línea puedes añadir...", añade un espacio, la palabra org y el nombre de la Unidad Organizativa entre comillas. Por ejemplo, si quisieras añadir los usuarios a la Unidad Organizativa "Alumnado ESO", puedes poner:
~~~
 org "Alumnado ESO"
~~~
Si "Alumnado ESO" fuese una subunidad de "Alumnado", se haría de la siguiente forma:
~~~
 org "Alumnado/Alumnado ESO"
~~~

Probado en macOS Catalina.
