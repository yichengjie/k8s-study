FROM centos:centos7.9.2009
RUN yum update && yum install -y python-pip
RUN pip install fortune
ADD fortuneloop.sh /bin/fortuneloop.sh
ENTRYPOINT [ "/bin/fortuneloop.sh" ]