#!/bin/bash

function check {
  $1 --version > /dev/null 2>&1 || { echo >&2 "Se requiere '$1' pero no ha sido encontrado. Instalación detenida."; exit 1; }
}

check git
check curl
check php
check docker
check docker-compose

if [ ! -e docker/nginx/Dockerfile ];
then
  export USERID=$(id -u)
  sed -e "s/USERID/$USERID/" docker/nginx/Dockerfile.dist > docker/nginx/Dockerfile
  sed -e "s/USERID/$USERID/" docker/php7-fpm/Dockerfile.dist > docker/php7-fpm/Dockerfile
fi

if [ ! -d simplesamlphp ];
then
  echo Clonando simplesamlphp...
  git clone https://github.com/simplesamlphp/simplesamlphp.git > /dev/null 2>&1
fi

cd simplesamlphp

if [ ! -e composer.phar ];
then
  echo Instalando composer...
  curl https://getcomposer.org/composer.phar -o composer.phar > /dev/null 2>&1
fi

echo Instalando dependencias...
php composer.phar require \
        "sgomez/simplesamlphp-module-oauth2" "~2.0" \
        "sgomez/simplesamlphp-module-dbal" "~1.0" \
        "sgomez/simplesamlphp-module-openidsir" "~1.0" \
        "simplesamlphp/simplesamlphp-module-openid" "^1.0" \
        "openid/php-openid" "dev-master#ee669c6a9d4d95b58ecd9b6945627276807694fb" > /dev/null 2>&1

if [ ! -e config/config.php ];
then
  echo Creando certificados ...
  [ -d cert ] || mkdir cert
  [ -d cache ] || mkdir cache
  openssl req -newkey rsa:2048 -new -x509 -days 3652 -nodes \
        -out cert/saml.crt -keyout cert/saml.pem \
        -subj "/C=ES/ST=Cordoba/L=Cordoba/O=Servicio de Informatica/OU=Soporte/CN=localhost" > /dev/null 2>&1

  echo Copiando configuración...
  cp ../config/authsources.php config/
  cp ../config/config.php config/
  cp ../config/module_*.php config/
  cp ../config/saml20-* metadata/

  export FINGERPRINT=$(openssl x509 -noout -fingerprint -in cert/saml.crt | cut -d= -f2 | tr [:upper:] [:lower:] | tr -d ':')
  sed -i -e "s/FINGERPRINT/${FINGERPRINT}/" metadata/saml20-idp-remote.php
fi

echo Creando máquinas ...
docker-compose up -d

until echo "status" | docker exec -i jt2016_uco_db mysql mysql --password=mysql > /dev/null 2>&1
do
  echo "Esperando a que la base de datos esté disponible..."
  sleep 2
done

echo Configurando base de datos
docker exec -i jt2016_uco_db mysqladmin --password=mysql create simplesamlphp > /dev/null 2>&1
echo "GRANT ALL PRIVILEGES ON simplesamlphp.* to 'root'@'%'" | docker exec -i jt2016_uco_db mysql mysql --password=mysql > /dev/null 2>&1
docker exec -i jt2016_uco_php /var/simplesamlphp/vendor/bin/dbalschema > /dev/null 2>&1

