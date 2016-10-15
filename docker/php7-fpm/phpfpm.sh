#!/usr/bin/env bash

echo "Init php-fpm daemon"
chown -R www-data. /var/simplesamlphp/cache
php-fpm7.0 -c /etc/php/7.0/fpm/php.ini --fpm-config /etc/php/7.0/fpm/php-fpm.conf -F
