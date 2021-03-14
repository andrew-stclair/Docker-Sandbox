# Base Image
FROM centos:latest

# Instanciated command
CMD ["/startup.sh"]
ENTRYPOINT ["sh"]

# Working Directory
WORKDIR /

# Environment Variables
ENV password toor

# Ports
EXPOSE 22
EXPOSE 5902

RUN yum -y update && yum -y install openssh-server passwd && mkdir /var/run/sshd9
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN echo "root:${password}" | chpasswd
RUN yum -y install epel-release && yum groupinstall "Xfce" -y && yum -y install tigervnc-server tigervnc-server-minimal && yum -y install file-roller && yum -y install java
RUN dbus-uuidgen > /var/lib/dbus/machine-id
RUN printf "password\npassword\n\n" | vncpasswd
RUN vncserver -rfbport 5902
RUN vncserver -kill :1
RUN echo '#!/bin/bash' > ~/.vnc/xstartup
RUN echo 'xrdb $HOME/.Xresources' >> ~/.vnc/xstartup
RUN echo 'startxfce4 &' >> ~/.vnc/xstartup
RUN chmod +x ~/.vnc/xstartup && cp /etc/X11/Xresources ~/.Xresources
RUN vncserver -rfbport 5902
RUN echo 'nohup vncserver -rfbport 5902 &' > /startup.sh
RUN echo '/usr/sbin/sshd -D &' >> /startup.sh