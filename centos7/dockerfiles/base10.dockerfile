
#
#    CentOS 7 (centos7) Base10 System (dockerfile)
#    Copyright (C) 2016-2017 Stafli
#    Luís Pedro Algarvio
#    This file is part of the Stafli Application Stack.
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

#
# Build
#

# Base image to use
FROM stafli/stafli.system.minimal:minimal10_centos7

# Labels to apply
LABEL description="Stafli Base System (stafli/stafli.system.base), Based on Stafli Minimal System (stafli/stafli.system.minimal)" \
      maintainer="lp@algarvio.org" \
      org.label-schema.schema-version="1.0.0-rc.1" \
      org.label-schema.name="Stafli Base System (stafli/stafli.system.base)" \
      org.label-schema.description="Based on Stafli Minimal System (stafli/stafli.system.minimal)" \
      org.label-schema.keywords="stafli, base, system, debian, centos, ubuntu, alpine" \
      org.label-schema.url="https://stafli.org/" \
      org.label-schema.license="GPLv3" \
      org.label-schema.vendor-name="Stafli" \
      org.label-schema.vendor-email="info@stafli.org" \
      org.label-schema.vendor-website="https://www.stafli.org" \
      org.label-schema.authors.lpalgarvio.name="Luis Pedro Algarvio" \
      org.label-schema.authors.lpalgarvio.email="lp@algarvio.org" \
      org.label-schema.authors.lpalgarvio.homepage="https://lp.algarvio.org" \
      org.label-schema.authors.lpalgarvio.role="Maintainer" \
      org.label-schema.registry-url="https://hub.docker.com/r/stafli/stafli.system.base" \
      org.label-schema.vcs-url="https://github.com/stafli-org/stafli.system.base" \
      org.label-schema.vcs-branch="master" \
      org.label-schema.os-id="centos" \
      org.label-schema.os-version-id="7" \
      org.label-schema.os-architecture="amd64" \
      org.label-schema.version="1.0"

#
# Arguments
#

#
# Environment
#

# Working directory to use when executing build and run instructions
# Defaults to /.
#WORKDIR /

# User and group to use when executing build and run instructions
# Defaults to root.
#USER root:root

#
# Packages
#

# Refresh the GPG keys
# Refresh the package manager
# Install the selected packages
#   Install the base packages
#    - mailcap: to provide mime support
#   Install the administration packages
#    - psmisc: for fuser and pstree, utilities that use the proc file system
#    - htop: for htop, an interactive process viewer
#    - iotop: for iotop, a simple top-like I/O monitor
#    - iftop: for iftop, a simple top-like network monitor
#    - lsof: for lsof, a utility to list open files
#   Install the programming packages
#    - bc: for bc, the GNU bc arbitrary precision calculator language
#    - mawk: for awk, a faster interpreter for the AWK Programming Language
#   Install the find and revision control packages
#    - less: for less, pager program similar to more
#    - file: for file. retrieves information about files
#    - locate: for locate, which maintains and queries an index of a directory tree
#    - diffutils: for diff, the file comparison utility
#   Install the archive and compression packages
#    - cpio: for cpio, the GNU cpio, a program to manage archives of files
#    - bzip2: for bzip2, a compression utility, which uses the Burrows–Wheeler algorithm
#    - zip: for zip, the InfoZip compression utility which uses various ZIP algorithms
#    - unzip: for unzip, the InfoZip decompression utility which uses various ZIP algorithms
#    - xz: for xz, the XZ compression utility, which uses Lempel-Ziv/Markov-chain algorithm
#   Install the network diagnosis packages
#    - net-tools: for arp, netstat, route and others, the NET-3 networking toolkit
#    - iproute: for ip and others, the newer tools for routing and network configuration
#    - iputils: for ping/6, tools to test the reachability of network hosts
#    - traceroute: for traceroute/6, tools to trace the network path to a remote host
#    - lft: for lft, the layer-four traceroute
#    - bind-utils: for nslookup and dig, the BIND DNS client programs
#   Install the network transfer packages
#    - wget: for wget, a network utility to download via FTP and HTTP protocols
#    - httpie: for HTTPie, a CLI HTTP utility that makes CLI interaction with HTTP-based services as human-friendly as possible
#    - rsync: for rsync, a fast and versatile remote (and local) file-copying tool
#    - openssh-clients: for ssh, a free client implementation of the Secure Shell protocol
#   Install the misc packages
#    - bash-completion: to add programmable completion for the bash shell
#    - pwgen: for pwgen, the automatic password generation tool
#    - dialog: for dialog, to provide prompts for the bash shell
#    - screen: for screen, the terminal multiplexer with VT100/ANSI terminal emulation
#    - byobu: for byobu, a text window manager, shell multiplexer and integrated DevOps environment
# Cleanup the package manager
RUN printf "Installing repositories and packages...\n" && \
    \
    printf "Refresh the GPG keys...\n" && \
    gpg --refresh-keys && \
    \
    printf "Refresh the package manager...\n" && \
    rpm --rebuilddb && yum makecache && \
    \
    printf "Install the selected packages...\n" && \
    yum install -y \
      mailcap \
      psmisc htop iotop iftop lsof \
      bc mawk \
      less file locate diffutils \
      cpio bzip2 zip unzip xz \
      net-tools iproute iputils traceroute lft bind-utils \
      wget httpie rsync openssh-clients \
      bash-completion pwgen dialog screen byobu && \
    \
    printf "Cleanup the package manager...\n" && \
    yum clean all && rm -Rf /var/lib/yum/* && rm -Rf /var/cache/yum/* && \
    \
    printf "Finished installing repositories and packages...\n";

#
# Configuration
#

#
# Run
#

# Command to execute
# Defaults to /bin/bash.
#CMD ["/bin/bash"]

# Ports to expose
# Defaults to none.
#EXPOSE ...

