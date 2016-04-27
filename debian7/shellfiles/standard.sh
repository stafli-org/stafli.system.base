#!/bin/bash
#
#    Debian 7 (wheezy) standard profile (shell)
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

# Workaround for docker commands
alias FROM="#";
alias MAINTAINER="#";
alias ENV='export';
alias ARG='export';
alias RUN='';
shopt -s expand_aliases;

# Suppress warnings about the terminal
printf "\
export TERM=\"linux\";\n\
export DEBIAN_FRONTEND=\"noninteractive\";\n\
" >> /etc/environment;
source /etc/environment;

# Load dockerfile
source "$(dirname $(readlink -f $0))/../dockerfiles/standard.dockerfile";

# Configure timezone and locales
printf "\
export TZ=\"Etc/UTC\";\n\
export LANGUAGE=\"en_US.UTF-8\";\n\
export LANG=\"en_US.UTF-8\";\n\
export LC_ALL=\"en_US.UTF-8\";\n\
" >> /etc/environment;
source /etc/environment;

