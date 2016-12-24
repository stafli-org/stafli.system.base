#
#    Makefile
#    Copyright (C) 2016 SOL-ICT
#    This file is part of the Docker General Purpose System Distro.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# If distro is not provided, default to all
ifndef DISTRO
	DISTRO:=all
endif

all: help

help:
	@echo "\
Docker General Purpose System Distro\n\
\n\
Syntax:\n\
make <command> DISTRO=<distribution>\n\
\n\
Issuing commands:\n\
By default, the target distribution will be all available.\n\
If you want to target a specific distribution, you will need to specify it.\n\
You can do this by adding DISTRO to the command.\n\
\n\
Available commands:\n\
- help:			This help text.\n\
- quick start:\n\
  - up:			Builds images and creates and starts containers, networks and volumes.\n\
  - down:		Stops and removes containers and networks.\n\
  - purge:		Purges containers, networks, volumes and images.\n\
- for images:\n\
  - img-ls:		Lists images, using docker, using docker.\n\
  - img-build:		Builds images from dockerfiles, using docker-compose.\n\
  - img-pull:		Pulls images from repository, using docker-compose.\n\
  - img-rm:		Removes images, using docker.\n\
- for containers:\n\
  - con-ls:		Lists containers, using docker-compose.\n\
  - con-create:		Creates containers, using docker-compose.\n\
  - con-rm:		Removes containers, using docker-compose.\n\
  - con-start:		Starts containers, using docker-compose.\n\
  - con-stop:		Stops containers, using docker-compose.\n\
  - con-restart:	Restarts containers, using docker-compose.\n\
  - con-pause:		Pauses containers, using docker-compose.\n\
  - con-unpause:	Unpauses containers, using docker-compose.\n\
  - con-inspect:	Inspects containers, using docker.\n\
  - con-ips:		Shows ips of containers, using docker.\n\
  - con-ports:		Shows logs of containers, using docker.\n\
  - con-top:		Shows processes of containers, using docker.\n\
  - con-logs:		Shows logs of containers, using docker-compose.\n\
  - con-events:		Shows events of containers, using docker-compose.\n\
- for networks:\n\
  - net-ls:		Lists networks, using docker network.\n\
  - net-create:		Creates networks, using docker network.\n\
  - net-rm:		Removes networks, using docker network.\n\
  - net-inspect:	Inspects networks, using docker network.\n\
- for volumes:\n\
  - vol-ls:		Lists volumes, using docker volume.\n\
  - vol-create:		Creates volumes, using docker volume.\n\
  - vol-rm:		Removes volumes, using docker volume.\n\
  - vol-inspect:	Inspects volumes, using docker volume.\n\
\n\
Available distributions:\n\
- debian8\n\
- debian7\n\
- centos7\n\
- centos6\n\
\n\
Example #1: quick start, with build\n\
 make up DISTRO=debian8;\n\
\n\
Example #2: quick start, with pull\n\
 make img-pull DISTRO=debian8;\n\
 make up DISTRO=debian8;\n\
\n\
Example #3: manual steps, with build\n\
 make img-build DISTRO=debian8;\n\
 make net-create DISTRO=debian8;\n\
 make vol-create DISTRO=debian8;\n\
 make con-create DISTRO=debian8;\n\
 make con-start DISTRO=debian8;\n\
 make con-ls DISTRO=debian8;\n\
"


up:
	@echo
	@echo Building images and creates and starts containers, networks and volumes...
	@echo
        ifeq ($(DISTRO), all)
		@echo Building images and creates and starts containers, networks and volumes for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose up)";
		@echo
		@echo Building images and creates and starts containers, networks and volumes for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose up)";
		@echo
		@echo Building images and creates and starts containers, networks and volumes for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose up)";
		@echo
		@echo Building images and creates and starts containers, networks and volumes for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose up)";
        else
		@echo Building images and creates and starts containers, networks and volumes for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose up)";
        endif


down:
	@echo
	@echo Stopping and removes containers and networks....
	@echo
        ifeq ($(DISTRO), all)
		@echo Stopping and removes containers and networks for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose down)";
		@echo
		@echo Stopping and removes containers and networks for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose down)";
		@echo
		@echo Stopping and removes containers and networks for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose down)";
		@echo
		@echo Stopping and removes containers and networks for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose down)";
        else
		@echo Stopping and removes containers and networks for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose down)";
        endif


purge:
	@echo
	@echo Purging containers, networks, volumes and images....
	@echo
        ifeq ($(DISTRO), all)
		@echo Purging containers, networks, volumes and images for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose down)";
		docker volume rm debian8_minimal_data;
		docker volume rm debian8_standard_data;
		docker volume rm debian8_devel_data;
		docker rmi solict/general-purpose-system-distro:debian8_minimal;
		docker rmi solict/general-purpose-system-distro:debian8_standard;
		docker rmi solict/general-purpose-system-distro:debian8_devel;
		@echo
		@echo Purging containers, networks, volumes and images for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose down)";
		docker volume rm debian7_minimal_data;
		docker volume rm debian7_standard_data;
		docker volume rm debian7_devel_data;
		docker rmi solict/general-purpose-system-distro:debian7_minimal;
		docker rmi solict/general-purpose-system-distro:debian7_standard;
		docker rmi solict/general-purpose-system-distro:debian7_devel;
		@echo
		@echo Purging containers, networks, volumes and images for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose down)";
		docker volume rm centos7_minimal_data;
		docker volume rm centos7_standard_data;
		docker volume rm centos7_devel_data;
		docker rmi solict/general-purpose-system-distro:centos7_minimal;
		docker rmi solict/general-purpose-system-distro:centos7_standard;
		docker rmi solict/general-purpose-system-distro:centos7_devel;
		@echo
		@echo Purging containers, networks, volumes and images for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose down)";
		docker volume rm centos6_minimal_data;
		docker volume rm centos6_standard_data;
		docker volume rm centos6_devel_data;
		docker rmi solict/general-purpose-system-distro:centos6_minimal;
		docker rmi solict/general-purpose-system-distro:centos6_standard;
		docker rmi solict/general-purpose-system-distro:centos6_devel;
        else
		@echo Purging containers, networks, volumes and images for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose down)";
		docker volume rm $(DISTRO)_minimal_data;
		docker volume rm $(DISTRO)_standard_data;
		docker volume rm $(DISTRO)_devel_data;
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_minimal;
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_standard;
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_devel;
        endif


img-ls:
	@echo
	@echo Listing images...
	@echo
        ifeq ($(DISTRO), all)
		@echo Listing images for debian8...
		docker images | grep -E "solict/general-purpose-system-distro.*debian8" | sort -n;
		@echo
		@echo Listing images for debian7...
		docker images | grep -E "solict/general-purpose-system-distro.*debian7" | sort -n;
		@echo
		@echo Listing images for centos7...
		docker images | grep -E "solict/general-purpose-system-distro.*centos7" | sort -n;
		@echo
		@echo Listing images for centos6...
		docker images | grep -E "solict/general-purpose-system-distro.*centos6" | sort -n;
        else
		@echo Listing images for $(DISTRO)...
		docker images | grep -E "solict/general-purpose-system-distro.*$(DISTRO)" | sort -n;
        endif


img-build:
	@echo
	@echo Building images...
	@echo
        ifeq ($(DISTRO), all)
		@echo Building images for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose build)";
		@echo
		@echo Building images for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose build)";
		@echo
		@echo Building images for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose build)";
		@echo
		@echo Building images for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose build)";
        else
		@echo Building images for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose build)";
        endif


img-pull:
	@echo
	@echo Pulling images...
	@echo
        ifeq ($(DISTRO), all)
		@echo Pulling images for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose pull)";
		@echo
		@echo Pulling images for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose pull)";
		@echo
		@echo Pulling images for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose pull)";
		@echo
		@echo Pulling images for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose pull)";
        else
		@echo Pulling images for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose pull)";
        endif


img-rm:
	@echo
	@echo Removing images...
	@echo
        ifeq ($(DISTRO), all)
		@echo Removing images for debian8...
		docker rmi solict/general-purpose-system-distro:debian8_minimal;
		docker rmi solict/general-purpose-system-distro:debian8_standard;
		docker rmi solict/general-purpose-system-distro:debian8_devel;
		@echo
		@echo Removing images for debian7...
		docker rmi solict/general-purpose-system-distro:debian7_minimal;
		docker rmi solict/general-purpose-system-distro:debian7_standard;
		docker rmi solict/general-purpose-system-distro:debian7_devel;
		@echo
		@echo Removing images for centos7...
		docker rmi solict/general-purpose-system-distro:centos7_minimal;
		docker rmi solict/general-purpose-system-distro:centos7_standard;
		docker rmi solict/general-purpose-system-distro:centos7_devel;
		@echo
		@echo Removing images for centos6...
		docker rmi solict/general-purpose-system-distro:centos6_minimal;
		docker rmi solict/general-purpose-system-distro:centos6_standard;
		docker rmi solict/general-purpose-system-distro:centos6_devel;
        else
		@echo Removing images for $(DISTRO)...
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_minimal;
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_standard;
		docker rmi solict/general-purpose-system-distro:$(DISTRO)_devel;
        endif


con-ls:
	@echo
	@echo Showing containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose ps)";
		@echo
		@echo Showing containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose ps)";
		@echo
		@echo Showing containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose ps)";
		@echo
		@echo Showing containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose ps)";
        else
		@echo Showing containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose ps)";
        endif


con-create:
	@echo
	@echo Creating containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Creating containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose create)";
		@echo
		@echo Creating containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose create)";
		@echo
		@echo Creating containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose create)";
		@echo
		@echo Creating containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose create)";
        else
		@echo Creating containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose create)";
        endif


con-rm:
	@echo
	@echo Removing containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Removing containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose rm)";
		@echo
		@echo Removing containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose rm)";
		@echo
		@echo Removing containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose rm)";
		@echo
		@echo Removing containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose rm)";
        else
		@echo Removing containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose rm)";
        endif


con-start:
	@echo
	@echo Starting containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Starting containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose start)";
		@echo
		@echo Starting containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose start)";
		@echo
		@echo Starting containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose start)";
		@echo
		@echo Starting containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose start)";
        else
		@echo Starting containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose start)";
        endif


con-stop:
	@echo
	@echo Stoping containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Stoping containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose stop)";
		@echo
		@echo Stoping containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose stop)";
		@echo
		@echo Stoping containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose stop)";
		@echo
		@echo Stoping containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose stop)";
        else
		@echo Stoping containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose stop)";
        endif


con-restart:
	@echo
	@echo Restarting containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Restarting containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose restart)";
		@echo
		@echo Restarting containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose restart)";
		@echo
		@echo Restarting containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose restart)";
		@echo
		@echo Restarting containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose restart)";
        else
		@echo Restarting containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose restart)";
        endif


con-pause:
	@echo
	@echo Pausing containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Pausing containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose pause)";
		@echo
		@echo Pausing containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose pause)";
		@echo
		@echo Pausing containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose pause)";
		@echo
		@echo Pausing containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose pause)";
        else
		@echo Pausing containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose pause)";
        endif


con-unpause:
	@echo
	@echo Unpausing containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Unpausing containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose unpause)";
		@echo
		@echo Unpausing containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose unpause)";
		@echo
		@echo Unpausing containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose unpause)";
		@echo
		@echo Unpausing containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose unpause)";
        else
		@echo Unpausing containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose unpause)";
        endif


con-inspect:
	@echo
	@echo Inspecting containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Inspecting containers for debian8...
		docker inspect debian8_minimal_1;
		docker inspect debian8_standard_1;
		docker inspect debian8_devel_1;
		@echo
		@echo Inspecting containers for debian7...
		docker inspect debian7_minimal_1;
		docker inspect debian7_standard_1;
		docker inspect debian7_devel_1;
		@echo
		@echo Inspecting containers for centos7...
		docker inspect centos7_minimal_1;
		docker inspect centos7_standard_1;
		docker inspect centos7_devel_1;
		@echo
		@echo Inspecting containers for centos6...
		docker inspect centos6_minimal_1;
		docker inspect centos6_standard_1;
		docker inspect centos6_devel_1;
        else
		@echo Inspecting containers for $(DISTRO)...
		docker inspect $(DISTRO)_minimal_1;
		docker inspect $(DISTRO)_standard_1;
		docker inspect $(DISTRO)_devel_1;
        endif

con-ips:
	@echo
	@echo Showing IP addresses of containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing IP addresses of containers for debian8...
		docker inspect debian8_minimal_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect debian8_standard_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect debian8_devel_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		@echo
		@echo Showing IP addresses of containers for debian7...
		docker inspect debian7_minimal_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect debian7_standard_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect debian7_devel_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		@echo
		@echo Showing IP addresses of containers for centos7...
		docker inspect centos7_minimal_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect centos7_standard_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect centos7_devel_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		@echo
		@echo Showing IP addresses of containers for centos6...
		docker inspect centos6_minimal_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect centos6_standard_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect centos6_devel_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
        else
		@echo Showing IP addresses of containers for $(DISTRO)...
		docker inspect $(DISTRO)_minimal_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect $(DISTRO)_standard_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
		docker inspect $(DISTRO)_devel_1 | grep -e "inspect" -e "\"NetworkID\"" -B 0 -A 8;
        endif


con-ports:
	@echo
	@echo Showing ports of containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing ports of containers for debian8...
		docker port debian8_minimal_1;
		docker port debian8_standard_1;
		docker port debian8_devel_1;
		@echo
		@echo Showing ports of containers for debian7...
		docker port debian7_minimal_1;
		docker port debian7_standard_1;
		docker port debian7_devel_1;
		@echo
		@echo Showing ports of containers for centos7...
		docker port centos7_minimal_1;
		docker port centos7_standard_1;
		docker port centos7_devel_1;
		@echo
		@echo Showing ports of containers for centos6...
		docker port centos6_minimal_1;
		docker port centos6_standard_1;
		docker port centos6_devel_1;
        else
		@echo Showing ports of containers for $(DISTRO)...
		docker port $(DISTRO)_minimal_1;
		docker port $(DISTRO)_standard_1;
		docker port $(DISTRO)_devel_1;
        endif


con-top:
	@echo
	@echo Showing processes of containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing processes of containers for debian8...
		docker top debian8_minimal_1;
		docker top debian8_standard_1;
		docker top debian8_devel_1;
		@echo
		@echo Showing processes of containers for debian7...
		docker top debian7_minimal_1;
		docker top debian7_standard_1;
		docker top debian7_devel_1;
		@echo
		@echo Showing processes of containers for centos7...
		docker top centos7_minimal_1;
		docker top centos7_standard_1;
		docker top centos7_devel_1;
		@echo
		@echo Showing processes of containers for centos6...
		docker top centos6_minimal_1;
		docker top centos6_standard_1;
		docker top centos6_devel_1;
        else
		@echo Showing processes of containers for $(DISTRO)...
		docker top $(DISTRO)_minimal_1;
		docker top $(DISTRO)_standard_1;
		docker top $(DISTRO)_devel_1;
        endif


con-logs:
	@echo
	@echo Showing logs of containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing logs of containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose logs)";
		@echo
		@echo Showing logs of containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose logs)";
		@echo
		@echo Showing logs of containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose logs)";
		@echo
		@echo Showing logs of containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose logs)";
        else
		@echo Showing logs of containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose logs)";
        endif


con-events:
	@echo
	@echo Showing events of containers...
	@echo
        ifeq ($(DISTRO), all)
		@echo Showing events of containers for debian8...
		bash -c "(cd debian8; set -o allexport; source .env; set +o allexport; docker-compose events)";
		@echo
		@echo Showing events of containers for debian7...
		bash -c "(cd debian7; set -o allexport; source .env; set +o allexport; docker-compose events)";
		@echo
		@echo Showing events of containers for centos7...
		bash -c "(cd centos7; set -o allexport; source .env; set +o allexport; docker-compose events)";
		@echo
		@echo Showing events of containers for centos6...
		bash -c "(cd centos6; set -o allexport; source .env; set +o allexport; docker-compose events)";
        else
		@echo Showing events of containers for $(DISTRO)...
		bash -c "(cd $(DISTRO); set -o allexport; source .env; set +o allexport; docker-compose events)";
        endif


net-ls:
	@echo
	@echo Listing networks...
	@echo
        ifeq ($(DISTRO), all)
		@echo Listing networks for debian8...
		docker network ls | grep -E "debian8" | sort -n;
		@echo
		@echo Listing networks for debian7...
		docker network ls | grep -E "debian7" | sort -n;
		@echo
		@echo Listing networks for centos7...
		docker network ls | grep -E "centos7" | sort -n;
		@echo
		@echo Listing networks for centos6...
		docker network ls | grep -E "centos6" | sort -n;
        else
		@echo Listing networks for $(DISTRO)...
		docker network ls | grep -E "$(DISTRO)" | sort -n;
        endif


net-create:
	@echo
	@echo Creating networks...
	@echo
        ifeq ($(DISTRO), all)
		@echo Creating networks for debian8...
		docker network create debian8_default;
		@echo
		@echo Creating networks for debian7...
		docker network create debian7_default;
		@echo
		@echo Creating networks for centos7...
		docker network create centos7_default;
		@echo
		@echo Creating networks for centos6...
		docker network create centos6_default;
        else
		@echo Creating networks for $(DISTRO)...
		docker network create $(DISTRO)_default;
        endif


net-rm:
	@echo
	@echo Removing networks...
	@echo
        ifeq ($(DISTRO), all)
		@echo Removing networks for debian8...
		docker network rm debian8_default;
		@echo
		@echo Removing networks for debian7...
		docker network rm debian7_default;
		@echo
		@echo Removing networks for centos7...
		docker network rm centos7_default;
		@echo
		@echo Removing networks for centos6...
		docker network rm centos6_default;
        else
		@echo Removing networks for $(DISTRO)...
		docker network rm $(DISTRO)_default;
        endif


net-inspect:
	@echo
	@echo Inspecting networks...
	@echo
        ifeq ($(DISTRO), all)
		@echo Inspecting networks for debian8...
		docker network inspect debian8_default;
		@echo
		@echo Inspecting networks for debian7...
		docker network inspect debian7_default;
		@echo
		@echo Inspecting networks for centos7...
		docker network inspect centos7_default;
		@echo
		@echo Inspecting networks for centos6...
		docker network inspect centos6_default;
        else
		@echo Inspecting networks for $(DISTRO)...
		docker network inspect $(DISTRO)_default;
        endif


vol-ls:
	@echo
	@echo Listing volumes...
	@echo
        ifeq ($(DISTRO), all)
		@echo Listing volumes for debian8...
		docker volume ls | grep -E "debian8" | sort -n;
		@echo
		@echo Listing volumes for debian7...
		docker volume ls | grep -E "debian7" | sort -n;
		@echo
		@echo Listing volumes for centos7...
		docker volume ls | grep -E "centos7" | sort -n;
		@echo
		@echo Listing volumes for centos6...
		docker volume ls | grep -E "centos6" | sort -n;
        else
		@echo Listing volumes for $(DISTRO)...
		docker volume ls | grep -E "$(DISTRO)" | sort -n;
        endif


vol-create:
	@echo
	@echo Creating volumes...
	@echo
        ifeq ($(DISTRO), all)
		@echo Creating volumes for debian8...
		docker volume create --driver local --name debian8_default_data;
		docker volume create --driver local --name debian8_standard_data;
		docker volume create --driver local --name debian8_devel_data;
		@echo
		@echo Creating volumes for debian7...
		docker volume create --driver local --name debian7_minimal_data;
		docker volume create --driver local --name debian7_standard_data;
		docker volume create --driver local --name debian7_devel_data;
		@echo
		@echo Creating volumes for centos7...
		docker volume create --driver local --name centos7_minimal_data;
		docker volume create --driver local --name centos7_standard_data;
		docker volume create --driver local --name centos7_devel_data;
		@echo
		@echo Creating volumes for centos6...
		docker volume create --driver local --name centos6_minimal_data;
		docker volume create --driver local --name centos6_standard_data;
		docker volume create --driver local --name centos6_devel_data;
        else
		@echo Creating volumes for $(DISTRO)...
		docker volume create --driver local --name $(DISTRO)_minimal_data;
		docker volume create --driver local --name $(DISTRO)_standard_data;
		docker volume create --driver local --name $(DISTRO)_devel_data;
        endif


vol-rm:
	@echo
	@echo Removing volumes...
	@echo
        ifeq ($(DISTRO), all)
		@echo Removing volumes for debian8...
		docker volume rm debian8_minimal_data;
		docker volume rm debian8_standard_data;
		docker volume rm debian8_devel_data;
		@echo
		@echo Removing volumes for debian7...
		docker volume rm debian7_minimal_data;
		docker volume rm debian7_standard_data;
		docker volume rm debian7_devel_data;
		@echo
		@echo Removing volumes for centos7...
		docker volume rm centos7_minimal_data;
		docker volume rm centos7_standard_data;
		docker volume rm centos7_devel_data;
		@echo
		@echo Removing volumes for centos6...
		docker volume rm centos6_minimal_data;
		docker volume rm centos6_standard_data;
		docker volume rm centos6_devel_data;
        else
		@echo Removing volumes for $(DISTRO)...
		docker volume rm $(DISTRO)_minimal_data;
		docker volume rm $(DISTRO)_standard_data;
		docker volume rm $(DISTRO)_devel_data;
        endif


vol-inspect:
	@echo
	@echo Inspecting volumes...
	@echo
        ifeq ($(DISTRO), all)
		@echo Inspecting volumes for debian8...
		docker volume inspect debian8_minimal_data;
		docker volume inspect debian8_standard_data;
		docker volume inspect debian8_devel_data;
		@echo
		@echo Inspecting volumes for debian7...
		docker volume inspect debian7_minimal_data;
		docker volume inspect debian7_standard_data;
		docker volume inspect debian7_devel_data;
		@echo
		@echo Inspecting volumes for centos7...
		docker volume inspect centos7_minimal_data;
		docker volume inspect centos7_standard_data;
		docker volume inspect centos7_devel_data;
		@echo
		@echo Inspecting volumes for centos6...
		docker volume inspect centos6_minimal_data;
		docker volume inspect centos6_standard_data;
		docker volume inspect centos6_devel_data;
        else
		@echo Inspecting volumes for $(DISTRO)...
		docker volume inspect $(DISTRO)_minimal_data;
		docker volume inspect $(DISTRO)_standard_data;
		docker volume inspect $(DISTRO)_devel_data;
        endif


.SILENT: help

