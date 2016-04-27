
#
#    Debian 8 (jessie) minimal profile (dockerfile)
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
# Arguments
#

ARG app_dropbear_listen_addr="0.0.0.0"
ARG app_dropbear_listen_port="22"
ARG app_dropbear_key_size="4096"

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
#  - mime-support: to provide mime support
# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - dropbear: for dropbear, a lightweight SSH2 server and client that replaces OpenSSH
#  - cron: for crond, the process scheduling daemon
#  - anacron: for anacron, the cron-like program that doesn't go by time
#  - rsyslog: for rsyslogd, the rocket-fast system for log processing
#  - logrotate: for logrotate, the log rotation utility
# Install administration packages
#  - pwgen: for pwgen, the automatic password generation tool
#  - debianutils: for which and others, basic administration packages
#  - procps: for kill, top and others, basic administration packages
#  - htop: for htop, an interactive process viewer
#  - iotop: for iotop, a simple top-like I/O monitor
#  - iftop: for iftop, a simple top-like network monitor
# Install programming packages
#  - bc: for bc, the GNU bc arbitrary precision calculator language
#  - sed: for sed, the GNU stream editor
#  - mawk: for awk, a faster interpreter for the AWK Programming Language
#  - perl-base: for perl, an interpreter for the Perl Programming languange
#  - python-minimal: for python, an interpreter for the Python Programming languange
# Install find and revision control packages
#  - file: for file. retrieves information about files
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
      bash locales tzdata mime-support \
      supervisor dropbear cron anacron rsyslog logrotate \
      pwgen debianutils procps htop iotop iftop \
      bc sed mawk perl-base python-minimal \
      file grep tree findutils diffutils \
      tar gzip bzip2 zip unzip xz-utils \
      iproute2 iputils-ping iputils-tracepath dnsutils netcat-openbsd \
      wget curl rsync \
      bash-completion dialog screen nano; \
    printf "# Remove the superfluous packages...\n"; \
    apt-get autoremove --purge; \
    printf "# Cleanup the Package Manager...\n"; \
    apt-get clean && rm -rf /var/lib/apt/lists/*;

#
# Configuration
#

# Configure root account, timezone and locales
RUN printf "Configure root account...\n"; \
    cp -R /etc/skel/. /root; \
    printf "Configure timezone...\n"; \
    echo "Etc/UTC" > /etc/timezone; \
    printf "Configure locales...\n"; \
    sed -i "s># en_US.UTF-8 UTF-8>en_US.UTF-8 UTF-8>" /etc/locale.gen && \
    locale-gen;
ENV TZ="Etc/UTC" \
    LANGUAGE="en_US.UTF-8" LANG="en_US.UTF-8" LC_ALL="en_US.UTF-8"

# Supervisor
RUN printf "Updading Supervisor configuration...\n"; \
    mkdir -p /var/log/supervisor; \
    \
    # ignoring /etc/default/supervisor \
    \
    # /etc/supervisor/supervisord.conf \
    file="/etc/supervisor/supervisord.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    perl -0p -i -e "s>\[supervisord\]\nlogfile>\[supervisord\]\nnodaemon=true\nlogfile>" ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/supervisor/conf.d/init.conf \
    file="/etc/supervisor/conf.d/init.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# init\n\
[program:init]\n\
command=/bin/bash -c \"supervisorctl start rclocal; supervisorctl start rsyslogd; supervisorctl start crond; sleep 5; supervisorctl start dropbear;\"\n\
autostart=true\n\
autorestart=false\n\
startsecs=0\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/supervisor/conf.d/rclocal.conf \
    file="/etc/supervisor/conf.d/rclocal.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# rclocal\n\
[program:rclocal]\n\
command=/bin/bash -c \"/etc/rc.local\"\n\
autostart=false\n\
autorestart=false\n\
startsecs=0\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/rc.local \
    file="/etc/rc.local"; \
    touch ${file} && chown root ${file} && chmod 755 ${file};

# Rsyslogd
RUN printf "Updading Rsyslog configuration...\n"; \
    \
    # /etc/supervisor/conf.d/rsyslogd.conf \
    file="/etc/supervisor/conf.d/rsyslogd.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# rsyslogd\n\
[program:rsyslogd]\n\
command=/bin/bash -c \"\$(which rsyslogd) -f /etc/rsyslog.conf -n\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/default/rsyslog \
    \
    # /etc/rsyslog.conf \
    file="/etc/rsyslog.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    # Disable kernel logging \
    perl -0p -i -e "s>\\$\\ModLoad imklog>#\\$\\ModLoad imklog>" ${file}; \
    # Enable cron logging \
    perl -0p -i -e "s>#cron\.\*>cron.*>" ${file}; \
    # Disable xconsole \
    perl -0p -i -e "s>daemon.*;mail>#daemon.*;mail>" ${file}; \
    perl -0p -i -e "s>\t*news.err;>#\tnews.err;>" ${file}; \
    perl -0p -i -e "s>\t\*\.\=debug>#\t*.debug>" ${file}; \
    perl -0p -i -e "s>\t\*\.\=debug>#\t*.debug>" ${file}; \
    perl -0p -i -e "s>\t*\*\.=notice;\*\.=warn\t\|/dev/xconsole>#\t*.=notice;*.=warn\t\|/dev/xconsole>" ${file}; \
    printf "Done patching ${file}...\n";

# Cron
RUN printf "Updading Cron configuration...\n"; \
    \
    # /etc/supervisor/conf.d/crond.conf \
    file="/etc/supervisor/conf.d/crond.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# crond\n\
[program:crond]\n\
command=/bin/bash -c \"\$(which cron) -f\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/default/cron \
    touch /etc/crontab;

# Dropbear
RUN printf "Updading Dropbear configuration...\n"; \
    \
    # /etc/supervisor/conf.d/dropbear.conf \
    file="/etc/supervisor/conf.d/dropbear.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# dropbear\n\
[program:dropbear]\n\
command=/bin/bash -c \"opts=\$(grep -o '^[^#]*' /etc/dropbear/dropbear.conf) && exec \$(which dropbear) \$opts -F\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/default/dropbear \
    \
    # /etc/dropbear/dropbear.conf \
    file="/etc/dropbear/dropbear.conf"; \
    # clear old file
    printf "#\n# dropbear.conf\n#\n" > ${file}; \
    # disable daemon/run in foreground \
    printf "\n# Run in foreground mode\n#-F\n" >> ${file}; \
    # change interface and port \
    printf "\n# Listen on specified address and port (Default: 0.0.0.0:22)\n-p ${app_dropbear_listen_addr}:${app_dropbear_listen_port}\n" >> ${file}; \
    # change ssh keys \
    printf "\n# Use the following ssh keys:\n-r /etc/dropbear/dropbear_rsa_host_key\n" >> ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # Remove persistent ssh keys \
    printf "\n# Removing persistent ssh keys...\n"; \
    rm -f /etc/dropbear/*host_key; \
    \
    # /etc/rc.local \
    file="/etc/rc.local"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    perl -0p -i -e "s>\nexit 0>\n# exit 0\n>" ${file}; \
    printf "\n\
# Recreate dropbear private keys\n\
# https://github.com/simonswine/docker-dropbear/blob/master/run.sh\n\
CONF_DIR=\"/etc/dropbear\";\n\
SSH_KEY_RSA=\"\${CONF_DIR}/dropbear_rsa_host_key\";\n\
SSH_KEY_DSS=\"\${CONF_DIR}/dropbear_dss_host_key\";\n\
SSH_KEY_ECDSA=\"\${CONF_DIR}/dropbear_ecdsa_host_key\";\n\
\n\
# Check if conf dir exists\n\
if [ ! -d \${CONF_DIR} ]; then\n\
    mkdir -p \${CONF_DIR};\n\
fi;\n\
chown root:root \${CONF_DIR};\n\
chmod 755 \${CONF_DIR};\n\
\n\
# Check if keys exists\n\
if [ ! -f \${SSH_KEY_DSS} ]; then\n\
    rm -f \${SSH_KEY_DSS};\n\
fi;\n\
if [ ! -f \${SSH_KEY_ECDSA} ]; then\n\
    rm -f \${SSH_KEY_ECDSA};\n\
fi;\n\
\n\
# Generate only the RSA key
if [ ! -f \${SSH_KEY_RSA} ]; then\n\
    dropbearkey -t rsa -f \${SSH_KEY_RSA} -s ${app_dropbear_key_size};\n\
fi;\n\
chown root:root \${SSH_KEY_RSA};\n\
chmod 600 \${SSH_KEY_RSA};\n\
\n\
exit 0\n" >> ${file}; \
    printf "Done patching ${file}...\n";

