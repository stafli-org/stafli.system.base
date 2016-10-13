
#
#    CentOS 7 (centos7) devel profile (dockerfile)
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

FROM solict/general-purpose-system-distro:centos7_standard
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
#  - pkgconfig: for pkg-config, a tool to manage compile and link flags for libraries
# Install compiler packages
#  - cpp: for cpp, the GNU C preprocessor (cpp) for the C Programming language
#  - gcc: for gcc, the GNU C compiler
#  - gcc-c++: for g++, the GNU C++ compiler
# Install library packages
#  - kernel-headers: the Linux Kernel - Headers for development
#  - glibc-headers: the Embedded GNU C Library - Development Libraries and Header Files
#  - pcre-devel: the Perl 5 Compatible Regular Expression Library - development files
#  - openssl-devel: the OpenSSL toolkit - development files
#  - gnutls-devel: GNU TLS library - development files
#  - libcurl-devel: the CURL library - development files (OpenSSL version)
#  - cyrus-sasl-devel: the Cyrus SASL library - development files
#  - openldap-devel: the OpenLDAP library - development files
#  - krb5-devel: the MIT Kerberos library - development files
#  - libxml2-devel: the GNOME XML library - development files
#  - zlib-devel:  the ZLib library - development files
RUN printf "Installing repositories and packages...\n" && \
    \
    printf "Install the required packages...\n" && \
    yum makecache && yum install -y \
      patch git \
      bison m4 re2c \
      autoconf automake make pkgconfig \
      cpp gcc gcc-c++ \
      kernel-headers glibc-headers pcre-devel \
      openssl-devel gnutls-devel libcurl-devel \
      cyrus-sasl-devel openldap-devel krb5-devel \
      libxml2-devel zlib-devel && \
    printf "Cleanup the Package Manager...\n" && \
    yum clean all && rm -Rf /var/lib/yum/*; \
    \
    printf "Finished installing repositories and packages...\n";

