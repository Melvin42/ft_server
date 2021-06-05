#!/bin/sh

/etc/init.d/mysql start

ln -s /etc/nginx/sites-available/my_server.localhost /etc/nginx/sites-enabled/

nginx -t

echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mariadb -u root -p --skip-password
echo "GRANT ALL ON wordpress.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" | mariadb -u root -p --skip-password
echo "FLUSH PRIVILEGES;" | mariadb -u root -p --skip-password

mariadb < /usr/share/phpMyAdmin/sql/create_tables.sql -u -root -p --skip-password

echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'pma'@'localhost' IDENTIFIED BY 'pmapass';" | mariadb -u root -p --skip-password
echo "FLUSH PRIVILEGES;" | mariadb -u root -p --skip-password

service php7.3-fpm start

nginx -g 'daemon off;'

#service nginx start
