FROM itzg/minecraft-server:master

RUN apt-get update
RUN apt-get install python3-pip -y

RUN pip3 install yglu

ENV YGLU_ENABLE_ENV=true
ENV BANANOCRAFT_WALLET_SEED=$BANANOCRAFT_WALLET_SEED
ENV WALLET_ID=$WALLET_ID
ENV MASTER_WALLET=$MASTER_WALLET
ENV BANANODE_IP=$BANANODE_IP

COPY config/config.yglu .

COPY BananoEconomy-1.0-SNAPSHOT.jar .

COPY craftbukkit-1.18.jar .

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

