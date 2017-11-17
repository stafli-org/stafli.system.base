
#
#    Debian 7 (wheezy) Base System (dockerfile)
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

FROM stafli/stafli.minimal.system:debian7_minimal

#
# Arguments
#

#
# Packages
#

# Install daemon and utilities packages
#  - supervisor: for supervisord, to launch and manage processes
#  - cron: for crond, the process scheduling daemon
#  - anacron: for anacron, the cron-like program that doesn't go by time
#  - rsyslog: for rsyslogd, the rocket-fast system for log processing
#  - logrotate: for logrotate, the log rotation utility
RUN printf "Installing repositories and packages...\n" && \
    \
    printf "Install the required packages...\n" && \
    apt-get update && apt-get install -qy \
      supervisor \
      cron anacron \
      rsyslog logrotate && \
    printf "# Cleanup the Package Manager...\n" && \
    apt-get clean && rm -rf /var/lib/apt/lists/*; \
    \
    printf "Finished installing repositories and packages...\n";

#
# Configuration
#

# Update daemon configuration
# - Supervisor
# - Rsyslog
# - Cron
RUN printf "Updading Daemon configuration...\n"; \
    \
    printf "Updading Supervisor configuration...\n"; \
    mkdir -p /var/log/supervisor; \
    \
    # ignoring /etc/default/supervisor \
    \
    # /etc/supervisor/supervisord.conf \
    file="/etc/supervisor/supervisord.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    perl -0p -i -e "s>\[supervisord\]\nlogfile>\[supervisord\]\nnodaemon=true\nlogfile>" ${file}; \
    perl -0p -i -e "s>\[unix_http_server\]\nfile=.*>\[unix_http_server\]\nfile=/dev/shm/supervisor.sock>" ${file}; \
    perl -0p -i -e "s>\[supervisorctl\]\nserverurl=.*>\[supervisorctl\]\nserverurl=unix:///dev/shm/supervisor.sock>" ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # /etc/supervisor/conf.d/init.conf \
    file="/etc/supervisor/conf.d/init.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# init\n\
[program:init]\n\
command=/bin/bash -c \"supervisorctl start rclocal; supervisorctl start rsyslogd; supervisorctl start crond;\"\n\
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
    touch ${file} && chown root ${file} && chmod 755 ${file}; \
    \
    printf "Updading Rsyslog configuration...\n"; \
    \
    # /etc/supervisor/conf.d/rsyslogd.conf \
    file="/etc/supervisor/conf.d/rsyslogd.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# Rsyslog\n\
[program:rsyslogd]\n\
command=/bin/bash -c \"\$(which rsyslogd) -f /etc/rsyslog.conf -c5 -n\"\n\
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
    printf "Done patching ${file}...\n"; \
    \
    printf "Updading Cron configuration...\n"; \
    \
    # /etc/supervisor/conf.d/crond.conf \
    file="/etc/supervisor/conf.d/crond.conf"; \
    printf "\n# Applying configuration for ${file}...\n"; \
    printf "# Cron\n\
[program:crond]\n\
command=/bin/bash -c \"\$(which cron) -f\"\n\
autostart=false\n\
autorestart=true\n\
\n" > ${file}; \
    printf "Done patching ${file}...\n"; \
    \
    # ignoring /etc/default/cron \
    touch /etc/crontab; \
    \
    printf "\n# Testing configuration...\n"; \
    echo "Testing $(which rsyslogd):"; $(which rsyslogd) -v; \
    printf "Done testing configuration...\n"; \
    \
    printf "Finished Daemon configuration...\n";

