FROM ubuntu:16.04

# install openssh-server
RUN apt-get update -y
RUN apt-get install -y openssh-server python

# Necessary to start up sshd
RUN mkdir /var/run/sshd
RUN echo 'root:screencast' | chpasswd

# start ssh
RUN /etc/init.d/ssh restart

# ssh settings
ADD ./.ssh /root/.ssh
# RUN rm -fr /root.ssh/authorized_keys
RUN mv /root/.ssh/ansible_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/*

# sshd_config settings
## Allow login as root user
RUN sed -ri 's/^#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config
## Allow public key authentication
RUN sed -ri 's/^#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# pam.d
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

CMD ["/usr/sbin/sshd", "-D"]
