FROM centos:7.4.1708

# install ansible
RUN yum -y install epel-release
RUN yum -y install python-pip --enablerepo=epel
RUN pip install --upgrade pip
RUN pip install ansible\==2.6.3

# install openssh-client
RUN yum update -y
RUN yum clean all
RUN yum install -y openssh-clients vim
RUN yum clean all

# ssh settings
ADD ./.ssh /root/.ssh
RUN chmod 700 /root/.ssh
RUN chmod 600 /root/.ssh/*

# ansible settings
ADD ./config/ansible_hosts /etc/ansible/hosts
ADD ./config/ansible.cfg /root/.ansible.cfg

CMD ["/sbin/init", "-D"]
