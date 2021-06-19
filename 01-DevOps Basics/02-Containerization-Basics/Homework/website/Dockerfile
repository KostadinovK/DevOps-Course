FROM ubuntu
LABEL maintainer="Kotsadin Kostadinov"
RUN apt-get update
RUN apt-get install -y tzdata
RUN apt-get install -y apache2
RUN apt-get install -y systemctl

RUN systemctl enable apache2
RUN systemctl start apache2

## for apt to be noninteractive
ARG DEBIAN_FRONTEND=noninteractive

WORKDIR var/www/html
COPY index.html index.html

EXPOSE 80
CMD ["apachectl", "-D", "FOREGROUND"]