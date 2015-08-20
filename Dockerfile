FROM debian:jessie
MAINTAINER Boris HUISGEN <bhuisgen@hbis.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update

RUN apt-get -y install locales
RUN dpkg-reconfigure locales && locale-gen C.UTF-8 && /usr/sbin/update-locale LANG=C.UTF-8
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

RUN apt-get -y install ucf procps iproute
RUN apt-get -y install mysql-client
RUN apt-get -y install supervisor
COPY etc/supervisor/ /etc/supervisor/
RUN apt-get -y install wget
RUN apt-get -y install libcurl3
RUN wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix/zabbix-agent_2.4.5-1+trusty_amd64.deb
RUN apt-get -y install --no-install-recommends pciutils libcurl3-gnutls libldap-2.4-2 cron curl jq netcat-openbsd sudo vim
RUN dpkg -i zabbix-agent_2.4.5-1+trusty_amd64.deb

RUN curl -sSL https://get.docker.com/ | sh
RUN usermod -aG docker root

RUN apt-get -y install python-dev
RUN apt-get -y install python-pip

RUN pip install websocket click docker-py
RUN pip install --upgrade six
COPY etc/zabbix/ /etc/zabbix/
COPY etc/sudoers.d/zabbix etc/sudoers.d/zabbix
RUN chmod 400 /etc/sudoers.d/zabbix
COPY etc/zabbix/crontab /var/spool/cron/crontabs/zabbix
RUN chmod 600 /var/spool/cron/crontabs/zabbix
RUN chown zabbix:crontab /var/spool/cron/crontabs/zabbix

COPY run.sh /
RUN chmod +x /run.sh
RUN chmod -R a+x /etc/zabbix/scripts/

EXPOSE 10050
ENTRYPOINT ["/run.sh"]
ENV DOCKER_HOST=tcp://swarm:2375
CMD [""]
