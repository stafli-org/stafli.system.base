
#
#    CentOS 7 (centos7) base profile (dockerfile)
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

FROM centos:centos7
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
# Add foreign repositories and GPG keys
#  - epel-release: for Extra Packages for Enterprise Linux (EPEL)
# Install base packages
#  - bash: for bash, the GNU Bash shell
#  - glibc-common: to provide common files for locale support
#  - tzdata: to provide time zone and daylight-saving time data
#  - pwgen: for pwgen, the automatic password generation tool
# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - dropbear: for dropbear, a lightweight SSH2 server and client that replaces OpenSSH
#  - cronie: for crond, the process scheduling daemon
#  - cronie-anacron: for anacron, the cron-like program that doesn't go by time
#  - rsyslog: for rsyslogd, the rocket-fast system for log processing
#  - logrotate: for logrotate, the log rotation utility
# Install administration packages
#  - which: for which, basic administration packages
#  - procps: for kill, top and others, basic administration packages
#  - htop: for htop, an interactive process viewer
#  - iotop: for iotop, a simple top-like I/O monitor
#  - iftop: for iftop, a simple top-like network monitor
# Install programming packages
#  - sed: for sed, the GNU stream editor
#  - mawk: for awk, a faster interpreter for the AWK Programming Language
#  - perl: for perl, an interpreter for the Perl Programming languange
#  - python: for python, an interpreter for the Python Programming languange
# Install find and revision control packages
#  - grep: for grep/egrep/fgrep, the GNU utilities to search text in files
#  - tree: for tree, displays directory tree, in color
#  - findutils: for find, the file search utility
#  - diffutils: for diff, the file comparison utility
# Install archive and compression packages
#  - tar: for tar, the GNU tar archiving utility
#  - gzip: for gzip, the GNU compression utility which uses DEFLATE algorithm
#  - bzip2: for bzip2, a compression utility, which uses the Burrows–Wheeler algorithm
#  - zip: for zip, the InfoZip compression utility which uses various ZIP algorithms
#  - unzip: for unzip, the InfoZip decompression utility which uses various ZIP algorithms
#  - xz-utils: for xz, the XZ compression utility, which uses Lempel-Ziv/Markov-chain algorithm
# Install network diagnosis packages
#  - iproute: for ip and others, the newer tools for routing and network configuration
#  - iputils: for ping/6, tools to test the reachability of network hosts
#  - traceroute: for traceroute/6, tools to trace the network path to a remote host
#  - bind-utils: for nslookup and dig, the BIND DNS client programs
#  - nc: for netcat, the OpenBSD rewrite of netcat - the TCP/IP swiss army knife
# Install network transfer packages
#  - wget: for wget, a network utility to download via FTP and HTTP protocols
#  - curl: for curl, a network utility to transfer data via FTP, HTTP, SCP, and other protocols
#  - rsync: for rsync, a fast and versatile remote (and local) file-copying tool
# Install misc packages
#  - bash-completion: to add programmable completion for the bash shell
#  - dialog: for dialog, to provide prompts for the bash shell
#  - screen: for screen, the terminal multiplexer with VT100/ANSI terminal emulation
#  - nano: for nano, a tiny editor based on pico
# Removed superfluous packages
#  - acl: for access control lists support. this is superfluous
#  - vim-minimal: for vim editor. nano editor is installed
RUN printf "# Install the Package Manager related packages...\n"; \
    yum makecache && yum install -y \
      openssl ca-certificates \
      yum-utils yum-plugin-priorities \
      yum-plugin-fastestmirror yum-plugin-keys \
      gnupg; \
    printf "# Install the repositories and refresh the GPG keys...\n"; \
    yum makecache && yum install -y \
      epel-release; \
    gpg --refresh-keys; \
    printf "# Install the required packages...\n"; \
    yum makecache && yum install -y \
      bash tzdata pwgen \
      supervisor dropbear cronie cronie-anacron rsyslog logrotate \
      which procps htop iotop iftop \
      sed mawk perl python \
      grep tree findutils diffutils \
      tar gzip bzip2 zip unzip xz \
      iproute iputils traceroute bind-utils nc \
      wget curl rsync \
      bash-completion dialog screen nano; \
    printf "# Remove the superfluous packages...\n"; \
    yum remove -y \
      acl \
      vim-minimal; \
    package-cleanup -q --leaves --exclude-bin | xargs -l1 yum remove -y; \
    printf "# Cleanup the Package Manager...\n"; \
    yum clean all && rm -Rf /var/lib/yum/*;

#
# Configuration
#

# Configure root account, timezone and locales
RUN printf "Configure root account...\n"; \
    cp -R /etc/skel/. /root; \
    printf "Configure timezone...\n"; \
    echo "Etc/UTC" > /etc/timezone; \
    printf "Configure locales...\n"; \
    yum makecache && yum reinstall -y glibc-common; \
    yum clean all && rm -Rf /var/lib/yum/*; \
    localedef --list-archive | grep -v -i ^en | xargs localedef --delete-from-archive; \
    mv /usr/lib/locale/locale-archive /usr/lib/locale/locale-archive.tmpl; \
    build-locale-archive; \
    localedef -v -c -i en_US -f UTF-8 en_US.UTF-8; \
    rm -Rf /usr/lib/locale/tmp;
ENV TZ="Etc/UTC" \
    LANGUAGE="en_US.UTF-8" LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

