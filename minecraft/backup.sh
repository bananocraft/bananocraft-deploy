#!/bin/bash

while true; do
    sleep $(($BACKUP_MINUTE_INTERVAL * 60))
    rm /data/.restored || true

    /bin/echo "Starting backup..."

    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backing up server."
    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-off
    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-all

    sleep 10

    echo "running restic"
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup backup /data
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup forget --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 --prune

    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-on
    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backup complete!"

    /bin/echo "Backup complete!"
done