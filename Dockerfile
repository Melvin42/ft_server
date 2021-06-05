# Dockerfile
FROM debian:buster
MAINTAINER melperri <melperri@student.42.fr>

# Installing dependencies
RUN apt-get update && apt-get install -y \
	nginx \
	mariadb-server \
	openssl \
	php-fpm \
	php-mysql \
	wordpress \
	&& rm -rf /var/lib/apt/lists/* \
	&& mkdir /var/www/my_server.localhost \
	&& mkdir /etc/nginx/ssl
#	&& chown -R $USER:$USER /var/www/my_server.localhost \
#	&& chown -R $USER:$USER /etc/nginx/ssl \
#	&& chmod -R 600 /etc/nginx/ssl

# Changing Workdir
WORKDIR /srcs

COPY ./srcs/config.sh .
COPY ./srcs/my_server.localhost /etc/nginx/sites-available/
COPY ./srcs/ssl_key/my_server.localhost.key /etc/nginx/ssl/
COPY ./srcs/ssl_key/my_server.localhost.key.pem /etc/nginx/ssl/
COPY ./srcs/ssl_key/my_server.localhost-x509.crt /etc/nginx/ssl/
COPY ./srcs/info.php /var/www/my_server.localhost/

RUN chmod 744 /srcs/config.sh
ENTRYPOINT ["/srcs/config.sh"]

EXPOSE 443
