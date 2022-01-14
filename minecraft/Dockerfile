FROM itzg/minecraft-server:master

RUN apt-get update
RUN apt-get install python3-pip -y

RUN pip3 install yqlu

ENV YGLU_ENABLE_ENV=true

#COPY BananoEconomy-1.0-SNAPSHOT.jar ./plugins/BananoEconomy-1.0-SNAPSHOT.jar
#
#COPY craftbukkit-1.18.jar ./plugins/craftbukkit-1.18.jar