
#
#    Debian 7 (wheezy) base profile (dockerfile)
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

FROM debian:wheezy
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>

#
# Environment
#

# Suppress warnings about the terminal and frontend and avoid prompts
ENV TERM="linux" \
    DEBIAN_FRONTEND="noninteractive"

#
# Packages
#

# Disable installation of optional apt packages and enable contrib and non-free components in debian repositories
RUN printf "# Disable installation of optional apt packages...\n"; \
    printf "\n# Disable recommended and suggested packages\n\
APT::Install-Recommends "\""false"\"";\n\
APT::Install-Suggests "\""false"\"";\n\
\n" >> /etc/apt/apt.conf; \
    printf "# Enable contrib and non-free components in debian repositories...\n"; \
    sed -i "s>main>main contrib non-free>" /etc/apt/sources.list;

# Install the Package Manager related packages and refresh the GPG keys
#  - openssl: for openssl, the OpenSSL cryptographic utility required for many packages
#  - ca-certificates: adds trusted PEM files of CA certificates to the system
#  - apt-utils: for apt-extracttemplates, used by debconf and to improve compatibility in docker
#  - apt-transport-https: to allow HTTPS connections to sources in apt
#  - gnupg: for gnupg, the GNU privacy guard cryptographic utility required by apt
#  - gnupg-curl: to add support for secure HKPS keyservers
#  - gpgv: for gpgv, the GNU privacy guard signature verification tool
# Add foreign repositories and GPG keys
#  - N/A
RUN printf "# Install the Package Manager related packages...\n"; \
    apt-key update && \
    apt-get update && apt-get install -qy \
      openssl ca-certificates \
      apt-utils apt-transport-https \
      gnupg gnupg-curl gpgv; \
    printf "# Install the repositories and refresh the GPG keys...\n"; \
    gpg --refresh-keys; \
    printf "# Cleanup the Package Manager...\n"; \
    apt-get clean && rm -rf /var/lib/apt/lists/*;

