#!/bin/bash

/bin/echo "Starting backup..."

/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backing up server."
/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-off
/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-all

sleep 10

latest=$(/bin/date '+%h-%d-%Y-%H-%M')

echo "tarring up backup"
/bin/tar -cpzf /backups/${SERVER_NAME}-backup-${latest}.tar.gz -P /data

sleep 10
echo "initiating uplink"
uplink cp /backups/${SERVER_NAME}-backup-${latest}.tar.gz sj://bananocraftbackups
#rclone --config /data/rclone.conf copy --progress /backups/${SERVER_NAME}-backup-${latest}.tar.gz bananocraftbackups:bananocraftbackups/${SERVER_NAME}
rm /backups/${SERVER_NAME}-backup-${latest}.tar.gz

/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-on
/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backup complete!"

backup_link=$(uplink share --not-after=none --url sj://bananocraftbackups/${SERVER_NAME}-backup-${latest}.tar.gz)
/usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "server backup now available at $backup_link"

/bin/echo "Backup complete!"

/bin/echo "server backup now available at $backup_link"