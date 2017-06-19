FROM onlyoffice/documentserver-builder
MAINTAINER Ascensio System SIA <support@onlyoffice.com>

# Make sure the package repository is up to date.
RUN apt-get -y update && \
    apt-get install -y openssh-server && \
    sed -i 's|session    required     pam_loginuid.so|session    optional     pam_loginuid.so|g' /etc/pam.d/sshd && \
    mkdir -p /var/run/sshd && \
    adduser --quiet jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    chown -R jenkins:jenkins /home/jenkins

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
