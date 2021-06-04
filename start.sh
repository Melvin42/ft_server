#!/bin/sh

systemctl start docker

sudo docker build -t my_server.localhost .

sudo docker run -it -p 443:443 my_server.localhost
