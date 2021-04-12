# docket install guide
https://docs.docker.com/engine/install/ubuntu/


## Uninstall old versions
Older versions of Docker were called docker, docker.io, or docker-engine. If these are installed, uninstall them:
```sh
sudo apt-get remove docker docker-engine docker.io containerd runc
```

## Install using the repository
Before you install Docker Engine for the first time on a new host machine, you need to set up the Docker repository. Afterward, you can install and update Docker from the repository.

SET UP THE REPOSITORY
Update the apt package index and install packages to allow apt to use a repository over HTTPS:

```sh
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
```

Add Docker’s official GPG key:
```sh
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

Use the following command to set up the stable repository. 
```sh
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

## INSTALL DOCKER ENGINE
Update the apt package index, and install the latest version of Docker Engine and containerd, or go to the next step to install a specific version:
```sh
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

## Uninstall Docker Engine
Uninstall the Docker Engine, CLI, and Containerd packages:

```sh
sudo apt-get purge docker-ce docker-ce-cli containerd.io
```

Images, containers, volumes, or customized configuration files on your host are not automatically removed. To delete all images, containers, and volumes:
```sh
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

## Manage Docker as a non-root user
The Docker daemon binds to a Unix socket instead of a TCP port. 
By default that Unix socket is owned by the user root and other users can only access it using sudo. 
The Docker daemon always runs as the root user.

If you don’t want to preface the docker command with sudo, create a Unix group called docker and add users to it. 
When the Docker daemon starts, it creates a Unix socket accessible by members of the docker group.

To create the docker group and add your user:

Create the docker group.
```sh
sudo groupadd docker
```

Add your user to the docker group.
```sh
sudo usermod -aG docker $USER
```

Exit and login again to verify that you can run docker commands without sudo.
```sh
docker run hello-world
```
