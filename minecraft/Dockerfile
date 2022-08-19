FROM itzg/minecraft-server:master

ENV SERVER_NAME=$SERVER_NAME
ENV RCON_PORT=$RCON_PORT
ENV RCON_PASSWORD=$RCON_PASSWORD
ENV YGLU_ENABLE_ENV=true
ENV WORLD_ID=$WORLD_ID
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
ENV DISCORD_WEBHOOK_URL=$DISCORD_WEBHOOK_URL

RUN apt-get update
RUN apt-get install sudo curl zip unzip python3-pip jq bash restic sudo rclone -y
RUN apt-get install tmux -y
RUN apt-get install htop -y
RUN apt-get install nano -y

RUN pip3 install yglu

RUN mkdir /backups

RUN git clone https://github.com/Tiiffi/mcrcon.git && cd mcrcon && make && make install

COPY config/config.yglu .
COPY config/bananominerconfig.yglu .
COPY config/bananosuiteconfig.yglu .
COPY config/geyserconfig.yglu .
COPY config/petshopconfig.yglu .

RUN mkdir -p /root/.config/rclone

COPY rclone.conf /root/.config/rclone/rclone.conf

RUN mkdir /scripts
COPY config/config.yglu /scripts
COPY config/bananominerconfig.yglu /scripts
COPY config/bananosuiteconfig.yglu /scripts
COPY config/geyserconfig.yglu /scripts
COPY config/petshopconfig.yglu /scripts

COPY --chmod=755 restore.sh .
COPY --chmod=755 check_backup.sh .
COPY --chmod=755 backup.sh .

RUN rm -f plugins/BananoEconomy-*.jar
RUN rm -f plugins/bananominer-*.jar
RUN rm -f plugins/bananosuite-*.jar
RUN rm -f plugins/EssentialsX-*.jar
RUN rm -f plugins/LuckPerms-*.jar
RUN rm -f plugins/Geyser-*.jar
RUN rm -f plugins/ViaVersion-*.jar
RUN rm -f plugins/PetShop-*.jar

#COPY deployplugins/BananoEconomy-1.1.0-SNAPSHOT.jar plugins/BananoEconomy-1.1.0-SNAPSHOT.jar
COPY deployplugins/BananoEconomy-1.1.3-SNAPSHOT.jar plugins/BananoEconomy-1.1.3-SNAPSHOT.jar
COPY deployplugins/EssentialsX-2.19.6.jar plugins/EssentialsX-2.19.6.jar
COPY deployplugins/LuckPerms-Bukkit-5.4.2.jar plugins/LuckPerms-Bukkit-5.4.2.jar
COPY deployplugins/Geyser-Spigot.jar plugins/Geyser-Spigot.jar
COPY deployplugins/Vault.jar plugins/Vault.jar
COPY deployplugins/bananominer-1.0.17.jar plugins/bananominer-1.0.17.jar
#COPY deployplugins/ViaVersion-4.3.2-SNAPSHOT.jar plugins/ViaVersion-4.3.2-SNAPSHOT.jar
COPY deployplugins/PetShop-1.4.1.jar plugins/PetShop-1.4.1.jar
#COPY deployplugins/bananosuite-1.0.5-SNAPSHOT.jar plugins/bananosuite-1.0.5-SNAPSHOT.jar

# Copy BananoSuite frame images
COPY additionaldeployfiles/Plugins/BananoSuite/frames/frame.png plugins/BananoSuite/frames/frame.png

COPY --chmod=755 entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

