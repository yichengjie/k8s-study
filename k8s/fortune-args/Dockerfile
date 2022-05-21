FROM ubuntu:latest
RUN apt-get update ; apt-get -y install fortune
ADD fortuneloop.sh /bin/fortuneloop.sh
ENTRYPOINT [ "/bin/fortuheloop.sh" ]
CMD [ "10" ]