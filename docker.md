# Docker

Docker is a utility to package, ship and run an application as a container
## Install docker

```
sudo pacman --sync docker
```
## Adding a user to docker group

If you want to be able to run the docker CLI command as a non-root user, add your user to the docker user group, re-login, and restart docker.service.
````
sudo gpasswd -a username docker
````

**WARNING:** 
``
Anyone added to the docker group is root equivalent because they can use the docker run --privileged command to start containers with root privileges.
``

## Running / enabling Docker as service
```
$ systemctl start docker
$ systemctl enable docker
$ systemctl stop docker
```

## Running RabbitMQ management container
These commands will assign a tagret address to eth0 interface
on the host and bind exposed ports to the target  ip address and port on the host

```
#ip addr add 192.168.1.61/21 dev eth0
$docker run -d --hostname my-rabbit --name some-rabbit -p 192.168.1.61:8080:15672 arm32v5/rabbitmq:3-management
```

