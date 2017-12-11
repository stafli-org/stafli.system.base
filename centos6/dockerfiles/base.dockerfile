
#
#    CentOS 6 (centos6) Base10 System (dockerfile)
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

FROM stafli/stafli.system.minimal:minimal10_centos6

#
# Arguments
#

#
# Packages
#

# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - logrotate: for logrotate, the log rotation utility
RUN printf "Installing repositories and packages...\n" && \
    \
    printf "Install the required packages...\n" && \
    rpm --rebuilddb && \
    yum makecache && yum install -y \
      supervisor logrotate && \
    printf "Cleanup the Package Manager...\n" && \
    yum clean all && rm -Rf /var/lib/yum/*; \
    \
    printf "Finished installing repositories and packages...\n";

#
# Configuration
#

# Update daemon configuration
# - Supervisor
RUN printf "Updading Daemon configuration...\n"; \
    \
    printf "Updading Supervisor configuration...\n"; \
    mkdir -p /var/log/supervisor; \
    \
    # ignoring /etc/sysconfig/supervisor \
    \
    # /etc/supervisord.conf \
    file="/etc/supervisord.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    perl -0p -i -e "s>nodaemon=false>nodaemon=true>" ${file}; \
    perl -0p -i -e "s>\[unix_http_server\]\nhttp_port=.*>\[unix_http_server\]\nhttp_port=/dev/shm/supervisor.sock>" ${file}; \
    perl -0p -i -e "s>\[supervisorctl\]\nserverurl=.*>\[supervisorctl\]\nserverurl=unix:///dev/shm/supervisor.sock>" ${file}; \
    # includes available only on v3.x+ \
    printf "Done patching ${file}...\n"; \
    \
    # init is not working at this point \
    \
    # /etc/supervisord.conf \
    file="/etc/supervisord.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# rclocal\n\
[program:rclocal]\n\
command=/bin/bash -c \"/etc/rc.local\"\n\
autostart=true\n\
autorestart=false\n\
startsecs=0\n\
\n" >> ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/rc.local \
    file="/etc/rc.local"; \
    touch ${file} && chown root ${file} && chmod 755 ${file}; \
    \
    printf "\n# Testing configuration...\n"; \
    printf "Done testing configuration...\n"; \
    \
    printf "Finished Daemon configuration...\n";

