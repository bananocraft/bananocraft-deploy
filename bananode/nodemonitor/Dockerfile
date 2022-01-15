FROM php:8.1.1-apache-buster
ENV BANANODE_IP=$BANANODE_IP
ENV NODE_ACCOUNT=$NODE_ACCOUNT

RUN apt-get update
RUN apt-get install git -y

RUN mkdir /opt/bananoNodeMonitor

RUN rm -rf /var/www/html/*

RUN git clone https://github.com/BananoTools/bananoNodeMonitor.git /var/www/html/.

COPY config.php /var/www/html/modules/config.php
COPY cmc_widget.php /var/www/html/modules/cmc_widget.php