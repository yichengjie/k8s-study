# version 0.0.1
FROM ubuntu:14.04
LABEL key="jAMES tURNBULL james@example.com"
RUN apt-get update && apt-get install -y nginx
RUN echo 'Hi, Iam in your container' \
    > /user/share/nginx/html/index.html
EXPOSE 80