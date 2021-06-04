#!/bin/sh

#systemctl allow 'Nginx HTTP'

#sudo mysql_secure_installation

/etc/init.d/mysql start

mkdir /var/www/my_server.localhost
chown -R $USER:$USER /var/www/my_server.localhost
mkdir /etc/nginx/ssl
chown -R $USER:$USER /etc/nginx/ssl
chmod -R 600 /etc/nginx/ssl
cp -R -v /srcs/ssl_key/my_server.localhost-x509.crt /etc/nginx/ssl/
cp -R -v /srcs/ssl_key/my_server.localhost.key.pem /etc/nginx/ssl/
cp -R -v /srcs/ssl_key/my_server.localhost.key /etc/nginx/ssl/
cp -R -v /srcs/my_server.localhost /etc/nginx/sites-available/

#	autoindex on;

ln -s /etc/nginx/sites-available/my_server.localhost /etc/nginx/sites-enabled/

nginx -t

echo "<?php
phpinfo();
?>" > /var/www/my_server.localhost/info.php

service nginx start
service nginx reload
