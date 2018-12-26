FROM centos:7.4.1708

# install ssh server
RUN yum update -y
RUN yum clean all
RUN yum install -y openssh-server vim
RUN yum clean all

# start ssh service
RUN systemctl enable sshd

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

CMD ["/sbin/init", "-D"]
