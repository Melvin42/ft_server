#!/bin/sh

/etc/init.d/mysql start

ln -s /etc/nginx/sites-available/my_server.localhost /etc/nginx/sites-enabled/

nginx -t

service php7.3-fpm start

nginx -g 'daemon off;'
