#!/bin/sh

#ufw allow 'Nginx HTTP'

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

#openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048

#echo "ssl_certificate /etc/ssl/certs/my_server.localhost-x509.crt;
#ssl_certificate /etc/ssl/private/my_server.localhost.key.pem;" > /etc/nginx/snippets/my_server.localhost.conf

#echo "# from https://cipherli.st/
## and https://raymii.org/s/tutorials/Strong_SSL_Security_On_nginx.html
#
#ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
#ssl_prefer_server_ciphers on;
#ssl_ciphers \"EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH\";
#ssl_ecdh_curve secp384r1;
#ssl_session_cache shared:SSL:10m;
#ssl_session_tickets off;
#ssl_stapling on;
#ssl_stapling_verify on;
#resolver 8.8.8.8 8.8.4.4 valid=300s;
#resolver_timeout 5s;
## Disable preloading HSTS for now.  You can use the commented out header line that includes
## the \"preload\" directive if you understand the implications.
##add_header Strict-Transport-Security \"max-age=63072000; includeSubdomains; preload\";
#add_header Strict-Transport-Security \"max-age=63072000; includeSubdomains\";
#add_header X-Frame-Options DENY;
#add_header X-Content-Type-Options nosniff;
#
#ssl_dhparam /etc/ssl/certs/dhparam.pem;" > /etc/nginx/snippets/ssl-params.conf
#
#	ssl_certificate /etc/nginx/ssl/my_server.localhost.key.pem;
#	ssl_certificate_key /etc/nginx/ssl/my_server.localhost.key;
#	include snippets/my_server.localhost.conf;
#	include snippets/ssl-params.conf;

echo "server {
	listen 443 ssl;

	ssl_certificate /etc/nginx/ssl/my_server.localhost-x509.crt;
	ssl_certificate_key /etc/nginx/ssl/my_server.localhost.key.pem;

	root /var/www/my_server.localhost;

	server_name my_server.localhost;

	location / {
		try_files $uri $uri/ =404;
	}

	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/car/run/php/php7.3-fpm.sock;
	}
}" > /etc/nginx/sites-available/my_server.localhost

ln -s /etc/nginx/sites-available/my_server.localhost /etc/nginx/sites-enabled/

nginx -t

echo "<?php
phpinfo();
?>" > /var/www/my_server.localhost/info.php

service nginx start
