
#
#    CentOS 6 (centos6) base profile (dockerfile)
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

FROM centos:centos6
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>

#
# Environment
#

# Suppress warnings about the terminal
ENV TERM="linux"

#
# Packages
#

# Install the Package Manager related packages and refresh the GPG keys
#  - openssl: for openssl, the OpenSSL cryptographic utility required for many packages
#  - ca-certificates: adds trusted PEM files of CA certificates to the system
#  - yum-utils: to provide additional utilities such as package-cleanup in yum
#  - yum-plugin-priorities: to provide priorities for packages from different repos in yum
#  - yum-plugin-fastestmirror: to provide fastest mirror selection from a mirrorlist in yum
#  - yum-plugin-keys: to provide key signing capabilities to yum
#  - gnupg: for gnupg, the GNU privacy guard cryptographic utility required by yum
RUN printf "# Install the Package Manager related packages...\n"; \
    yum makecache && yum install -y \
      openssl ca-certificates \
      yum-utils yum-plugin-priorities \
      yum-plugin-fastestmirror yum-plugin-keys \
      gnupg; \
    gpg --refresh-keys; \
    printf "# Cleanup the Package Manager...\n"; \
    yum clean all && rm -Rf /var/lib/yum/*;

