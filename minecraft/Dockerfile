FROM itzg/minecraft-server:master

RUN apt-get update
RUN apt-get install python3-pip -y

RUN pip3 install yglu

ENV YGLU_ENABLE_ENV=true
ENV BANANOCRAFT_WALLET_SEED=$BANANOCRAFT_WALLET_SEED
ENV WALLET_ID=$WALLET_ID
ENV MASTER_WALLET=$MASTER_WALLET
ENV BANANODE_IP=bananode
ENV MONGO_INITDB_ROOT_USERNAME=$MONGO_INITDB_ROOT_USERNAME
ENV MONGO_INITDB_ROOT_PASSWORD=$MONGO_INITDB_ROOT_PASSWORD
ENV MONGO_URI=$MONGO_URI

COPY config/config.yglu .

COPY BananoEconomy-1.0-SNAPSHOT.jar plugins/BananoEconomy-1.0-SNAPSHOT.jar
COPY Vault.jar plugins/Vault.jar

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

