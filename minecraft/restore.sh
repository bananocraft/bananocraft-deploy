#!/bin/bash

echo "restoring from backup $RESTORE_VERSION"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
#RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/benis-backup unlock || true
mkdir /restorefiles
mkdir /restore
mkdir /restorefiles/data
mkdir /restorefiles/data/plugins
mkdir /restorefiles/data/plugins/BananoEconomy
mkdir /restorefiles/data/plugins/BananoMiner
mkdir /restorefiles/data/plugins/BananoSuite
mkdir /restorefiles/data/plugins/BananoSuite/frames
mkdir /restorefiles/data/plugins/PetShop
mkdir /restorefiles/data/plugins/Geyser-Spigot
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore $RESTORE_VERSION --target /restorefiles
#RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/benis-backup restore $RESTORE_VERSION --target /restorefiles
yglu /scripts/config.yglu > /restorefiles/data/plugins/BananoEconomy/config.yml
yglu /scripts/bananominerconfig.yglu > /restorefiles/data/plugins/BananoMiner/config.yml
yglu /scripts/geyserconfig.yglu > /restorefiles/data/plugins/Geyser-Spigot/config.yml
yglu /scripts/petshopconfig.yglu > /restorefiles/data/plugins/PetShop/config.yml
yglu /scripts/bananosuiteconfig.yglu > /restorefiles/data/plugins/BananoSuite/config.yml

# Remove any old plugins that we don't include in the deployment any more. The ones we want will be redeployed as part of the server deployment.
rm -f /restorefiles/data/plugins/*.jar
rm -f /restorefiles/data/plugins/CoreProtect/database.db

sudo chown -R 1000:1000 /restorefiles
sudo chown -R 1000:1000 /data
zip -r /restore/restore.zip /restorefiles
rm -rf /restorefiles
export GENERIC_PACK=/restore/restore.zip

touch /data/.restored