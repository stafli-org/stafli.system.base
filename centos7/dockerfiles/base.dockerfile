
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
# Arguments
#

ARG app_dropbear_listen_addr="0.0.0.0"
ARG app_dropbear_listen_port="22"
ARG app_dropbear_key_size="4096"

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
#  - mailcap: to provide mime support
# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - dropbear: for dropbear, a lightweight SSH2 server and client that replaces OpenSSH
#  - cronie: for crond, the process scheduling daemon
#  - cronie-anacron: for anacron, the cron-like program that doesn't go by time
#  - rsyslog: for rsyslogd, the rocket-fast system for log processing
#  - logrotate: for logrotate, the log rotation utility
# Install administration packages
#  - pwgen: for pwgen, the automatic password generation tool
#  - which: for which, basic administration packages
#  - procps: for kill, top and others, basic administration packages
#  - htop: for htop, an interactive process viewer
#  - iotop: for iotop, a simple top-like I/O monitor
#  - iftop: for iftop, a simple top-like network monitor
# Install programming packages
#  - bc: for bc, the GNU bc arbitrary precision calculator language
#  - sed: for sed, the GNU stream editor
#  - mawk: for awk, a faster interpreter for the AWK Programming Language
#  - perl: for perl, an interpreter for the Perl Programming languange
#  - python: for python, an interpreter for the Python Programming languange
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
      bash tzdata mailcap \
      supervisor dropbear cronie cronie-anacron rsyslog logrotate \
      pwgen which procps htop iotop iftop \
      bc sed mawk perl python \
      file grep tree findutils diffutils \
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

# Supervisor
RUN printf "Updading Supervisor configuration...\n"; \
    mkdir -p /var/log/supervisor; \
    \
    # ignoring /etc/sysconfig/supervisor \
    \
    # /etc/supervisord.conf \
    file="/etc/supervisord.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    perl -0p -i -e "s>nodaemon=false>nodaemon=true>" ${file}; \
    perl -0p -i -e "s>files = supervisord.d/\*\.ini>files = supervisord.d/*.ini\nfiles = supervisord.d/*.conf\n>" ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/supervisord.d/init.conf \
    file="/etc/supervisord.d/init.conf"; \
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
    # /etc/supervisord.d/rclocal.conf \
    file="/etc/supervisord.d/rclocal.conf"; \
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
    # /etc/supervisord.d/rsyslogd.conf \
    file="/etc/supervisord.d/rsyslogd.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# rsyslogd\n\
[program:rsyslogd]\n\
command=/bin/bash -c \"\$(which rsyslogd) -f /etc/rsyslog.conf -n\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/sysconfig/rsyslog \
    \
    # /etc/rsyslog.conf \
    file="/etc/rsyslog.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    # Disable kernel logging \
    perl -0p -i -e "s>\\$\\ModLoad imklog>#\\$\\ModLoad imklog>" ${file}; \
    # Enable socket input and local logging \
    # http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/ \
    perl -0p -i -e "s>#\\$\\ModLoad imuxsock>\\$\\ModLoad imuxsock>" ${file}; \
    perl -0p -i -e "s>\\$\\OmitLocalLogging on>\\$\\OmitLocalLogging off>" ${file}; \
    # Disable systemd (journald) logging \
    # http://www.projectatomic.io/blog/2014/09/running-syslog-within-a-docker-container/ \
    perl -0p -i -e "s>\\$\\ModLoad imjournal>#\\$\\ModLoad imjournal>" ${file}; \
    perl -0p -i -e "s>\\$\\IMJournalStateFile>#\\$\\IMJournalStateFile>" ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/rsyslog.d/listen.conf \
    file="/etc/rsyslog.d/listen.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    # Disable systemd (journald) logging \
    perl -0p -i -e "s>\\$\\SystemLogSocketName>#\\$\\SystemLogSocketName>" ${file}; \
    printf "Done patching ${file}...\n";

# Cron
RUN printf "Updading Cron configuration...\n"; \
    \
    # /etc/supervisord.d/crond.conf \
    file="/etc/supervisord.d/crond.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# crond\n\
[program:crond]\n\
command=/bin/bash -c \"\$(which crond) -n\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/sysconfig/crond \
    touch /etc/crontab;

# Dropbear
RUN printf "Updading Dropbear configuration...\n"; \
    \
    # /etc/supervisord.d/dropbear.conf \
    file="/etc/supervisord.d/dropbear.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# dropbear\n\
[program:dropbear]\n\
command=/bin/bash -c \"opts=\$(grep -o '^[^#]*' /etc/dropbear/dropbear.conf) && exec \$(which dropbear) \$opts -F\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/sysconfig/dropbear \
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

