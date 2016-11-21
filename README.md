# Autenticación de webs SPA con SimpleSAMLphp y OpenID de Rediris

Esta página es la demo presentada en la charla 
[Autenticación de webs SPA con SimpleSAMLphp y OpenID de Rediris](http://www.rediris.es/jt/jt2016/ponencias/?id=jt2016-jt-sesi_paral5b-a25b3c1.pdf)
de las [Jornadas Técnicas de Rediris 2016 en Valencia](http://www.rediris.es/jt/jt2016/).

## Requisitos

* git
* curl
* php >= 5.3
* docker >= 1.9
* docker-compose

## Instalación

Ejecutar el script `install.sh` con un usuario con permisos para ejecutar docker.

## Desinstalación

Ejecutar el script `uninstall.sh` con el mismo usuario.

## Acceso a la web:

* Consola de simpleSAMLphp: [http://localhost/simplesamlphp](http://localhost/simplesamlphp)
  Usuario: admin
  Clave: jt2016
  
* Aplicación: [http://localhost/app_dev.php/](http://localhost/app_dev.php/)

## Problemas conocidos

La versión de Docker de MacOS tiene un bug conocido que hace que vaya extremadamente lento.
