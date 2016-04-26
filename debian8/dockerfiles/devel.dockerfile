
#
#    Debian 8 (jessie) devel profile (dockerfile)
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

FROM solict/general-purpose-system-distro:debian8_base
MAINTAINER Luís Pedro Algarvio <lp.algarvio@gmail.com>

#
# Packages
#

# Install revision control packages
#  - patch: for patch, the pach creator and applier tool
#  - git: for git, the Git distributed revision control system client
# Install parser packages
#  - bison: for bison, a YACC-compatible parser generator
#  - m4: for m4, the GNU m4 which is an interpreter for a macro processing language
#  - re2c: for r2ec, a tool for generating fast C-based recognizers
# Install build tools packages
#  - autoconf: for autoconf, a automatic configure script builder for FSF source packages
#  - automake: for automake, a tool for generating GNU Standards-compliant Makefiles
#  - make: for make, the GNU make which is an utility for Directing compilation
#  - pkg-config: for pkg-config, a tool to manage compile and link flags for libraries
# Install compiler packages
#  - cpp: for cpp, the GNU C preprocessor (cpp) for the C Programming language
#  - gcc: for gcc, the GNU C compiler
#  - g++: for g++, the GNU C++ compiler
# Install library packages
#  - linux-libc-dev: the Linux Kernel - Headers for development
#  - libc6-dev: the Embedded GNU C Library - Development Libraries and Header Files
#  - libpcre3-dev: the Perl 5 Compatible Regular Expression Library - development files
#  - libssl-dev: the OpenSSL toolkit - development files
#  - libgnutls28-dev: GNU TLS library - development files
#  - libcurl4-openssl-dev: the CURL library - development files (OpenSSL version)
#  - libsasl2-dev: the Cyrus SASL library - development files
#  - libldap2-dev: the OpenLDAP library - development files
#  - libkrb5-dev: the MIT Kerberos library - development files
#  - libxml2-dev: the GNOME XML library - development files
#  - zlib1g-dev:  the ZLib library - development files
RUN printf "# Install the required packages...\n"; \
    apt-get update && apt-get install -qy \
      patch git \
      bison m4 re2c \
      autoconf automake make pkg-config \
      cpp gcc g++ \
      linux-libc-dev libc6-dev libpcre3-dev \
      libssl-dev libgnutls28-dev libcurl4-openssl-dev \
      libsasl2-dev libldap2-dev libkrb5-dev \
      libxml2-dev zlib1g-dev; \
    printf "# Cleanup the Package Manager...\n"; \
    apt-get clean && rm -rf /var/lib/apt/lists/*;

