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

RUN apt-get update
RUN apt-get install curl unzip python3-pip bash restic rclone -y

RUN pip3 install yglu

RUN mkdir /backups

RUN git clone https://github.com/Tiiffi/mcrcon.git && cd mcrcon && make && make install

RUN curl -L https://github.com/storj/storj/releases/latest/download/uplink_linux_amd64.zip -o uplink_linux_amd64.zip
RUN unzip -o uplink_linux_amd64.zip
RUN chmod 755 uplink
RUN sudo mv uplink /usr/local/bin/uplink

COPY accessgrant.txt .
RUN uplink import accessgrant.txt


# Copy hello-cron file to the cron.d directory
COPY backup-cron /etc/cron.d/backup-cron

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/backup-cron

# Apply cron job
RUN crontab /etc/cron.d/backup-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

COPY config/config.yglu .

RUN mkdir -p /root/.config/rclone

COPY rclone.conf /root/.config/rclone/rclone.conf

COPY --chmod=755 restore.sh .
COPY --chmod=755 backup.sh .

COPY BananoEconomy-1.0-SNAPSHOT.jar plugins/BananoEconomy-1.0-SNAPSHOT.jar
COPY Vault.jar plugins/Vault.jar

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

