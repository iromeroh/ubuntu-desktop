# Builds a Docker image with Ubuntu, mysql-server and mysql-workbench
# and some graphic tools.
#

FROM x11vnc/desktop:latest

USER root
WORKDIR /tmp

ENV MYSQL_USER=mysql \
    MYSQL_VERSION=5.7.26 \
    MYSQL_DATA_DIR=/var/lib/mysql \
    MYSQL_RUN_DIR=/run/mysqld \
    MYSQL_LOG_DIR=/var/log/mysql

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server \
    mysql-workbench \
 && rm -rf ${MYSQL_DATA_DIR} \
 && rm -rf /var/lib/apt/lists/*

COPY entrypoint.sh /sbin/entrypoint.sh

RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3306/tcp
	
USER $DOCKER_USER
RUN echo '@lxterminal' >> $DOCKER_HOME/.config/lxsession/LXDE/autostart
USER root

WORKDIR $DOCKER_HOME
