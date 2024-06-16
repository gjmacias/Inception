#!/bin/bash

# Esperar a que la base de datos MariaDB se inicie completamente (como precaución)
sleep 30

if [ ! -f "/var/www/wordpress/wp-config.php" ]; then
    wp config create --dbname=$SQL_DATABASE --dbuser=$SQL_USER --dbpass=$SQL_PASSWORD --dbhost=mariadb:3306 --path=/var/www/wordpress
    wp core install --url="http://localhost" --title="Mi Sitio" --admin_user="admin" --admin_password="admin_password" --admin_email="admin@example.com" --path=/var/www/wordpress --skip-email
fi

wp user create usuario2 usuario2@example.com --role=editor --user_pass=usuario2_password --path=/var/www/wordpress --skip-email

if [ ! -d "/run/php" ]; then
    mkdir -p /run/php
fi

/usr/sbin/php-fpm7.3 -F

