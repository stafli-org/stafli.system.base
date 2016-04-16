# Docker General Purpose System Distro
General-purpose system distro builds based on [Debian](https://www.debian.org/) and [CentOS](https://www.centos.org/), and developed as scripts for [Docker](https://www.docker.com/).

Requires [Docker Compose](https://docs.docker.com/compose/) 1.6.x or higher due to the [version 2](https://docs.docker.com/compose/compose-file/#versioning) format of the docker-compose.yml files.

The docker-compose.yml are separated by distribution and require .env files to function properly.  
A rudimentary script [docker-compose-helper.sh](../../tree/master/docker-compose-helper.sh) is provided to help with loading these.

## Distributions
The profiles use the official images as a starting point:
- __Debian__, from the [official repository](https://hub.docker.com/_/debian/)
  - [Debian 8 (jessie)](../../tree/master/debian8)
  - [Debian 7 (wheezy)](../../tree/master/debian7)
- __CentOS__, from the [official repository](https://hub.docker.com/_/centos/)
  - [CentOS 7 (centos7)](../../tree/master/centos7)
  - [CentOS 6 (centos6)](../../tree/master/centos6)

## Profiles
These are the profiles described by the dockerfiles:
- Base, built with common software for all distributions

## Images
These are the [resulting images](https://hub.docker.com/r/solict/general-purpose-system-distro/tags/) upon building:
- solict/general-purpose-system-distro:debian8_base
- solict/general-purpose-system-distro:debian7_base
- solict/general-purpose-system-distro:centos7_base
- solict/general-purpose-system-distro:centos6_base

## Containers
These containers are generated upon issuing a create:
- debian8_base_xxx
- debian7_base_xxx
- centos7_base_xxx
- centos6_base_xxx

## Usage

### From GitHub repository (advanced)

1. Download the repository [zip file](https://github.com/solict/docker-general-purpose-system-distro/archive/master.zip) and unpack it or clone the repository using:  
`git clone https://github.com/solict/docker-general-purpose-system-distro.git`
2. Navigate to the project directory with a terminal and type:  
`docker-compose-helper --project=<distro> <operation>`

Where <distro> is the distribution/directory and <operation> is the desired docker-compose operation.

Examples:
```
./docker-compose-helper.sh --project=debian7 build
./docker-compose-helper.sh --project=debian7 create
./docker-compose-helper.sh --project=debian7 start
./docker-compose-helper.sh --project=debian7 stop
./docker-compose-helper.sh --project=debian7 rm
```

## Credits
Docker General Purpose System Distro  
Copyright (C) 2016 SOL-ICT  
Luís Pedro Algarvio

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