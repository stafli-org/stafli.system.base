
#
#    Debian 8 (jessie) base profile (dockerfile)
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

FROM debian:jessie
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
# Install base packages
#  - bash: for bash, the GNU Bash shell
#  - locales: to provide common files for locale support
#  - tzdata: to provide time zone and daylight-saving time data
#  - pwgen: for pwgen, the automatic password generation tool
# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - dropbear: for dropbear, a lightweight SSH2 server and client that replaces OpenSSH
#  - cron: for crond, the process scheduling daemon
#  - anacron: for anacron, the cron-like program that doesn't go by time
#  - rsyslog: for rsyslogd, the rocket-fast system for log processing
#  - logrotate: for logrotate, the log rotation utility
# Install administration packages
#  - debianutils: for which and others, basic administration packages
#  - procps: for kill, top and others, basic administration packages
#  - htop: for htop, an interactive process viewer
#  - iotop: for iotop, a simple top-like I/O monitor
#  - iftop: for iftop, a simple top-like network monitor
# Install programming packages
#  - sed: for sed, the GNU stream editor
#  - mawk: for awk, a faster interpreter for the AWK Programming Language
#  - perl-base: for perl, an interpreter for the Perl Programming languange
#  - python-minimal: for python, an interpreter for the Python Programming languange
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
#  - iproute2: for ip and others, the newer tools for routing and network configuration
#  - iputils-ping: for ping/6, tools to test the reachability of network hosts
#  - iputils-tracepath: for traceroute/6, tools to trace the network path to a remote host
#  - dnsutils: for nslookup and dig, the BIND DNS client programs
#  - netcat-openbsd: for netcat, the OpenBSD rewrite of netcat - the TCP/IP swiss army knife
# Install network transfer packages
#  - wget: for wget, a network utility to download via FTP and HTTP protocols
#  - curl: for curl, a network utility to transfer data via FTP, HTTP, SCP, and other protocols
#  - rsync: for rsync, a fast and versatile remote (and local) file-copying tool
# Install misc packages
#  - bash-completion: to add programmable completion for the bash shell
#  - dialog: for dialog, to provide prompts for the bash shell
#  - screen: for screen, the terminal multiplexer with VT100/ANSI terminal emulation
#  - nano: for nano, a tiny editor based on pico
RUN printf "# Install the Package Manager related packages...\n"; \
    apt-key update && \
    apt-get update && apt-get install -qy \
      openssl ca-certificates \
      apt-utils apt-transport-https \
      gnupg gnupg-curl gpgv; \
    printf "# Install the repositories and refresh the GPG keys...\n"; \
    gpg --refresh-keys; \
    printf "# Install the required packages...\n"; \
    apt-get update && apt-get install -qy \
      bash locales tzdata pwgen \
      supervisor dropbear cron anacron rsyslog logrotate \
      debianutils procps htop iotop iftop \
      sed mawk perl-base python-minimal \
      grep tree findutils diffutils \
      tar gzip bzip2 zip unzip xz-utils \
      iproute2 iputils-ping iputils-tracepath dnsutils netcat-openbsd \
      wget curl rsync \
      bash-completion dialog screen nano; \
    printf "# Remove the superfluous packages...\n"; \
    apt-get autoremove --purge; \
    printf "# Cleanup the Package Manager...\n"; \
    apt-get clean && rm -rf /var/lib/apt/lists/*;

