FROM ubuntu:18.04
ENV REFERSHED_AT=2014-06-01

RUN apt-get -yqq update
RUN apt-get -yqq install nodejs npm
#RUN ln -s /usr/bin/nodejs /usr/bin/node


RUN mkdir -p /var/log/nodeapp

ADD nodeapp /opt/nodeapp/

WORKDIR /opt/nodeapp

# RUN npm config set registry https://registry.npm.taobao.org

RUN npm config set strict-ssl false

RUN ["npm", "install"] 

VOLUME ["/var/log/nodeapp"]

EXPOSE 3000

ENTRYPOINT ["nodejs", "server.js"]