#!/bin/bash

echo "restoring from backup $RESTORE_VERSION"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
mkdir /restorefiles
mkdir /restore
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore $RESTORE_VERSION --target /restorefiles
sudo chown -R 1000:1000 /restorefiles
sudo chown -R 1000:1000 /data
zip -r /restore/restore.zip /restorefiles
rm -rf /restorefiles
export GENERIC_PACK=/restore/restore.zip

touch /data/.restored