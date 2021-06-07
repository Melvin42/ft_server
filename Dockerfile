FROM debian:buster

MAINTAINER melperri <melperri@student.42.fr>

RUN apt-get update && apt-get install -y \
	nginx \
	mariadb-server \
	openssl \
	php-fpm \
	php-mysql \
	wordpress \
	php-curl \
	php-gd \
	php-intl \
	php-mbstring \
	php-soap \
	php-xml \
	php-xmlrpc \
	php-zip \
	php-json\
	&& rm -rf /var/lib/apt/lists/* \
	&& apt-get clean -y \
	&& mkdir /var/www/my_server.localhost \
	&& mkdir /etc/nginx/ssl \
	&& mkdir /usr/share/phpMyAdmin \
	&& mkdir /usr/share/phpMyAdmin/tmp \
	&& chmod 777 /usr/share/phpMyAdmin/tmp

WORKDIR /srcs

COPY ./srcs/config.sh .
COPY ./srcs/my_server.localhost /etc/nginx/sites-available/
COPY ./srcs/phpMyAdmin.conf /etc/nginx/sites-available/
COPY ./srcs/ssl_key/my_server.localhost.key /etc/nginx/ssl/
COPY ./srcs/ssl_key/my_server.localhost.key.pem /etc/nginx/ssl/
COPY ./srcs/ssl_key/my_server.localhost-x509.crt /etc/nginx/ssl/
COPY ./srcs/info.php /var/www/my_server.localhost/
COPY ./srcs/wp-config.php /var/www/my_server.localhost/
COPY ./srcs/config.inc.php /var/www/my_server.localhost/
COPY ./srcs/wordpress/. /var/www/my_server.localhost/
COPY ./srcs/phpMyAdmin-4.9.0.1-all-languages/. /var/www/my_server.localhost/

RUN chmod 744 /srcs/config.sh

ENTRYPOINT ["/srcs/config.sh"]

EXPOSE 443
