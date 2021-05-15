#!/bin/sh
echo --configuring ip interface
ip addr add 192.168.1.61/21 dev eth0
echo --starting Docker
systemctl start docker
docker run -d --hostname my-rabbit -name some-rabbit -p 192.168.1.61:8080:15672 arm32v5/rabbitmq:3-management
echo --enabling mqtt plugin
docker exec some-rabbit rabbitmq-plugins enable rabbitmq_mqtt