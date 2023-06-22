FROM itzg/minecraft-server:latest

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
ENV CHECK_BACKUP=$CHECK_BACKUP
ENV RESTORE_FROM_BACKUP=$RESTORE_FROM_BACKUP
ENV RESTORE_VERSION=$RESTORE_VERSION
ENV BACKUP_MINUTE_INTERVAL=$BACKUP_MINUTE_INTERVAL
ENV DISCORD_WEBHOOK_URL=$DISCORD_WEBHOOK_URL

#ENV MYSQL_URI=$MYSQL_URI
#ENV MYSQL_PORT=$MYSQL_PORT

#ENV MYSQL_BANANOCRAFTUSER=$MYSQL_BANANOCRAFTUSER
#ENV MYSQL_BANANOCRAFTPASSWORD=$MYSQL_BANANOCRAFTPASSWORD

#ENV MYSQL_BANANOSUITEUSER=$MYSQL_BANANOSUITEUSER
#ENV MYSQL_BANANOSUITEPASSWORD=$MYSQL_BANANOSUITEPASSWORD

#ENV MYSQL_BANANOMINERUSER=$MYSQL_BANANOMINERUSER
#ENV MYSQL_BANANOMINERPASSWORD=$MYSQL_BANANOMINERPASSWORD

RUN apt-get update
RUN apt-get install sudo curl zip unzip python3-pip jq bash restic sudo rclone -y
RUN apt-get install tmux -y
RUN apt-get install htop -y
RUN apt-get install nano -y
RUN apt-get install openssh-server -y
# RUN apt-get install sshd -y

RUN pip3 install yglu

RUN mkdir /backups

RUN git clone https://github.com/Tiiffi/mcrcon.git && cd mcrcon && make && make install

COPY config/config.yglu .
COPY config/bananominerconfig.yglu .
COPY config/bananosuiteconfig.yglu .
COPY config/bananochestsconfig.yglu .
COPY config/geyserconfig.yglu .
COPY config/petshopconfig.yglu .
COPY config/pvptoggle.yglu .

RUN mkdir -p /root/.config/rclone

COPY rclone.conf /root/.config/rclone/rclone.conf

RUN mkdir /scripts
COPY config/config.yglu /scripts
COPY config/bananominerconfig.yglu /scripts
COPY config/bananosuiteconfig.yglu /scripts
COPY config/bananochestsconfig.yglu /scripts
COPY config/geyserconfig.yglu /scripts
COPY config/petshopconfig.yglu /scripts
COPY config/pvptoggle.yglu /scripts

COPY --chmod=755 restore.sh .
COPY --chmod=755 check_backup.sh .
COPY --chmod=755 backup.sh .

COPY additionaldeployfiles/server-icon.png .

RUN rm -f plugins/BananoEconomy-*.jar
RUN rm -f plugins/bananominer-*.jar
RUN rm -f plugins/bananosuite-*.jar
RUN rm -f plugins/bananochests*.jar
RUN rm -f plugins/EssentialsX-*.jar
RUN rm -f plugins/LuckPerms-*.jar
RUN rm -f plugins/Geyser-*.jar
RUN rm -f plugins/ViaVersion-*.jar
RUN rm -f plugins/PetShop-*.jar
RUN rm -f plugins/PvPToggle-*.jar
RUN rm -f plugins/8631.jar
RUN rm -f plugins/CoreProtect*.jar
RUN rm -f plugins/NoEncryption*.jar
RUN rm -f plugins/grimac*.jar

COPY deployplugins/BananoEconomy-1.2.5-SNAPSHOT.jar plugins/BananoEconomy-1.2.5-SNAPSHOT.jar
COPY deployplugins/bananominer-1.0.35.jar plugins/bananominer-1.0.35.jar
COPY deployplugins/bananosuite-1.0.15-SNAPSHOT.jar plugins/bananosuite-1.0.15-SNAPSHOT.jar
COPY deployplugins/bananochests-1.0.1-SNAPSHOT.jar plugins/bananochests-1.0.1-SNAPSHOT.jar

COPY deployplugins/EssentialsX-2.20.0.jar plugins/EssentialsX-2.20.0.jar
COPY deployplugins/LuckPerms-Bukkit-5.4.79.jar plugins/LuckPerms-Bukkit-5.4.79.jar
COPY deployplugins/Geyser-Spigot.jar plugins/Geyser-Spigot.jar
COPY deployplugins/Vault.jar plugins/Vault.jar
COPY deployplugins/PetShop-1.4.1.jar plugins/PetShop-1.4.1.jar
COPY deployplugins/CoreProtect-21.3.jar plugins/CoreProtect-21.3.jar

COPY deployplugins/grimac-2.3.43.jar plugins/grimac-2.3.43.jar
#COPY deployplugins/NoEncryption-1.19.4-5.2.jar plugins/NoEncryption-1.19.4-5.2.jar
COPY deployplugins/NoEncryption-1.20.1-5.2.jar plugins/NoEncryption-1.20.1-5.2.jar

# Copy BananoSuite frame images
COPY additionaldeployfiles/Plugins/BananoSuite/frames/frame.png plugins/BananoSuite/frames/frame.png

COPY --chmod=755 entrypoint.sh .

RUN mkdir /root/.ssh
RUN touch /root/.ssh/authorized_keys
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEWUMQ0uBwXpPavVmWijhQF+3JJ4TYHGXD3gTGhsmSov mconstant" >> /root/.ssh/authorized_keys
RUN echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEaIq4irJKOKx6qbsvp/m7/T6dn0f7/GFYfHD7/coKuA allhailbanano" >> /root/.ssh/authorized_keys

RUN service ssh start

COPY sshd_config /etc/ssh/sshd_config

EXPOSE 22

ENTRYPOINT ["./entrypoint.sh"]

