FROM php:8.1.1-apache-buster
ENV BANANODE_IP=$BANANODE_IP
ENV NODE_ACCOUNT=$NODE_ACCOUNT

RUN apt-get update
RUN apt-get install git -y

RUN mkdir /opt/bananoNodeMonitor

RUN git -C /opt/bananoNodeMonitor pull || git clone https://github.com/BananoTools/bananoNodeMonitor.git /opt/bananoNodeMonitor

COPY config.php .

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]