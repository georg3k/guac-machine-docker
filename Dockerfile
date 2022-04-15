FROM centos:7

MAINTAINER George K <12208636+georg3k@users.noreply.github.com>

# 
RUN yum install -y epel-release && \
    yum install -y \
        fontconfig \
        libX11 \
        openbox \
        supervisor \
        xrdp && \
    yum clean all

# Create default user and setup openbox autostart
RUN adduser user && \
    echo "user:user" | chpasswd && \
    echo "/opt/my_app/start.sh &" >> /etc/xdg/openbox/autostart

# Copy supervisord configuration
ADD etc /etc
ADD docker-entrypoint.sh /docker-entrypoint.sh

# General setup
VOLUME ["/home"]
EXPOSE 3389 22 9001
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["supervisord",  "-n"]

# Add app binaries
ADD my_app /opt/my_app
