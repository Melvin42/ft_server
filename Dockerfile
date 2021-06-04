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
	wordpress 

#COPY ./srcs/config.sh .
#COPY ./srcs/ssl_key/my_server.localhost.key.pem /srcs/ssl_key/
#COPY ./srcs/ssl_key/my_server.localhost.key /srcs/ssl_key/

# Changing Workdir
WORKDIR /srcs
ADD ./srcs . 

CMD chmod 764 config.sh; ./config.sh

EXPOSE 443
VOLUME ./srcs/logs
