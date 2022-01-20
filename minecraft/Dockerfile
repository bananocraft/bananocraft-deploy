FROM itzg/minecraft-server:master

ENV SERVER_NAME=$SERVER_NAME
ENV RCON_PORT=$RCON_PORT
ENV RCON_PASSWORD=$RCON_PASSWORD
ENV YGLU_ENABLE_ENV=true
ENV BANANOCRAFT_WALLET_SEED=$BANANOCRAFT_WALLET_SEED
ENV WALLET_ID=$WALLET_ID
ENV MASTER_WALLET=$MASTER_WALLET
ENV BANANODE_IP=bananode
ENV MONGO_INITDB_ROOT_USERNAME=$MONGO_INITDB_ROOT_USERNAME
ENV MONGO_INITDB_ROOT_PASSWORD=$MONGO_INITDB_ROOT_PASSWORD
ENV MONGO_URI=$MONGO_URI
ENV SSH_USER=$SSH_USER
ENV SSH_PASSWORD=$SSH_PASSWORD
ENV RCLONE_CONFIG_BANANOCRAFTBACKUPS_TYPE=storj
ENV RCLONE_CONFIG_BANANOCRAFTBACKUPS_ACCESS_GRANT=$RCLONE_CONFIG_BANANOCRAFTBACKUPS_ACCESS_GRANT
ENV RESTIC_PASSWORD=$RESTIC_PASSWORD
ENV CHECK_BACKUP=false
ENV RESTORE_FROM_BACKUP=false
ENV RESTORE_VERSION=latest
ENV BACKUP_MINUTE_INTERVAL=60

RUN apt-get update
RUN apt-get install curl unzip python3-pip bash restic rclone -y

RUN pip3 install yglu

RUN mkdir /backups

RUN git clone https://github.com/Tiiffi/mcrcon.git && cd mcrcon && make && make install

COPY config/config.yglu .

RUN mkdir -p /root/.config/rclone

COPY rclone.conf /root/.config/rclone/rclone.conf

COPY --chmod=755 restore.sh .
COPY --chmod=755 check_backup.sh .
COPY --chmod=755 backup.sh .

COPY BananoEconomy-1.1.0-SNAPSHOT.jar plugins/BananoEconomy-1.0-SNAPSHOT.jar
COPY Vault.jar plugins/Vault.jar

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

