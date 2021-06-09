#!/bin/sh

/etc/init.d/mysql start

sleep 2

ln -s /etc/nginx/sites-available/my_server.localhost /etc/nginx/sites-enabled/

echo "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;" | mariadb -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'melperri'@'localhost' IDENTIFIED BY 'password';" | mariadb -u root
mariadb wordpress < /home/srcs/wordpress.sql -u root
echo "FLUSH PRIVILEGES;" | mariadb -u root

echo "CREATE DATABASE phpmyadmin;" | mariadb -u root
echo "GRANT ALL PRIVILEGES ON phpmyadmin.* TO 'melperri'@'localhost' IDENTIFIED BY 'password';" | mariadb -u root
mariadb < /var/www/my_server.localhost/phpMyAdmin/sql/create_tables.sql -u root
echo "FLUSH PRIVILEGES;" | mariadb -u root

service php7.3-fpm start

nginx -g 'daemon off;'
