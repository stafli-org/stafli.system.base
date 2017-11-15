# Stafli Base System
Stafli Base System builds are based on [Debian](https://www.debian.org/) and [CentOS](https://www.centos.org/), and developed as scripts for [Docker](https://www.docker.com/).  
This project is part of the [Stafli Application Stack](https://github.com/stafli-org/).

Requires [Docker Compose](https://docs.docker.com/compose/) 1.6.x or higher due to the [version 2](https://docs.docker.com/compose/compose-file/#versioning) format of the docker-compose.yml files.

There are docker-compose.yml files per distribution, as well as docker-compose.override.yml and .env files, which may be used to override configuration.
An optional [Makefile](../../tree/master/Makefile) is provided to help with loading these with ease and perform commands in batch.

Scripts are also provided for each distribution to help test and deploy the installation procedures in non-Docker environments.

The images are automatically built at a [repository](https://hub.docker.com/r/stafli/stafli.base.system) in the Docker Hub registry.

## Distributions
The services use the official images as a starting point:
- __Debian__, from the [official repository](https://hub.docker.com/_/debian/)
  - [Debian 8 (jessie)](../../tree/master/debian8)
  - [Debian 7 (wheezy)](../../tree/master/debian7)
- __CentOS__, from the [official repository](https://hub.docker.com/_/centos/)
  - [CentOS 7 (centos7)](../../tree/master/centos7)
  - [CentOS 6 (centos6)](../../tree/master/centos6)

## Services
These are the services described by the dockerfile and docker-compose files:
- Base, built on Minimal System and additional daemon packages

## Images
These are the [resulting images](https://hub.docker.com/r/stafli/stafli.base.system/tags/) upon building:
- Base:
  - stafli/stafli.base.system:debian8_base
  - stafli/stafli.base.system:debian7_base
  - stafli/stafli.base.system:centos7_base
  - stafli/stafli.base.system:centos6_base

## Containers
These containers can be created from the images:
- Base:
  - debian8_base_xxx
  - debian7_base_xxx
  - centos7_base_xxx
  - centos6_base_xxx

## Usage

### From Docker Hub repository (manual)

Note: this method will not allow you to use the docker-compose files nor the script.

1. To pull the images, try typing:  
`docker pull <image_url>`
2. You can start a new container interactively by typing:  
`docker run -ti <image_url> /bin/bash`

Where <image_url> is the full image url (lookup the image list above).

Example:
```
docker pull stafli/stafli.base.system:debian8_base

docker run -ti stafli/stafli.base.system:debian8_base /bin/bash
```

### From GitHub repository (automated)

1. Download the repository [zip file](https://github.com/stafli-org/stafli.base.system/archive/master.zip) and unpack it or clone the repository using:  
`git clone https://github.com/stafli-org/stafli.base.system.git`
2. Navigate to the project directory through the terminal:  
`cd stafli.base.system`
3. Type in the desired operation through the terminal:  
`make <operation> DISTRO=<distro>`

Where <distro> is the distribution/directory and <operation> is the desired docker-compose operation.

Example:
```
git clone https://github.com/stafli-org/stafli.base.system.git
cd stafli.base.system
make build DISTRO=debian8
make netup DISTRO=debian8
make create DISTRO=debian8
make start DISTRO=debian8
make ps DISTRO=debian8
make stop DISTRO=debian8
make rm DISTRO=debian8
make netdown DISTRO=debian8
```

## Credits
Stafli Base System  
Copyright (C) 2016-2017 Stafli  
Luís Pedro Algarvio  
This project is part of the Stafli Application Stack.

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
