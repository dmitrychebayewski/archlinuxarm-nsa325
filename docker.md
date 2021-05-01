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

