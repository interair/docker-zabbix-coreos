FROM ubuntu:wily
MAINTAINER Boris HUISGEN <bhuisgen@hbis.fr>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get -y upgrade

RUN apt-get -y install ucf procps iproute
RUN apt-get -y install mysql-client
RUN apt-get -y install supervisor
COPY etc/supervisor/ /etc/supervisor/
RUN apt-get -y install wget
RUN apt-get -y install libcurl3
RUN wget http://repo.zabbix.com/zabbix/2.4/ubuntu/pool/main/z/zabbix/zabbix-agent_2.4.5-1+trusty_amd64.deb
RUN apt-get -y install --no-install-recommends pciutils libcurl3-gnutls libldap-2.4-2 cron curl jq netcat-openbsd sudo vim
RUN dpkg -i zabbix-agent_2.4.5-1+trusty_amd64.deb
RUN apt-get -y install python-pip
RUN apt-get update && apt-get install -y docker.io
RUN usermod -aG docker root
RUN pip install docker-py
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
CMD [""]
