FROM bananocoin/banano

RUN apt-get update
RUN apt-get install curl gzip -y

RUN curl https://banano.steampoweredtaco.com/download/snapshot.ldb.gz -o snapshot.ldb.gz

RUN gunzip snapshot.ldb.gz

RUN mkdir /root/BananoData

RUN mv snapshot.ldb /root/BananoData/data.ldb

