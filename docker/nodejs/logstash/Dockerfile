FROM ubuntu:18.04

LABEL user="James Turnbull"  email="james@example.com"

ENV REFRESHED_AT=2014-06-01

RUN apt-get -y update
RUN apt-get -y install wget gnupg gnupg1  gnupg2
RUN wget -qO - http://packages.elasticsearch.org/GPG-KEY-elasticsearch  | apt-key add -
RUN echo 'deb http://package.elasticsearch.org/logstash/1.4/debian stable main' > /etc/apt/sources.list.d/logstash.list
RUN apt-get -y update
RUN apt-get -y install logstash

ADD logstash.conf /etc/

WORKDIR /opt/logstash

ENTRYPOINT [ "bin/logstash" ]

CMD [ "--config=/etc/logstash.conf" ]


