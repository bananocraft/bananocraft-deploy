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
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup init || true
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup backup /data
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup forget --keep-hourly 48 --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 --prune
    if [ $? -eq 0 ]; then
      /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backup complete!"
      /bin/echo "Backup complete!"
    else
      /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "Backups not complete. Notify mconstant#4986 to fix backups for ${SERVER_NAME}. Attempting to send discord webhook automatically."
      curl -H "Content-Type: application/json" -d "{\"username\": \"bananocraftbot\", \"content\": \"Backups on bananocraft server ${SERVER_NAME} need to be fixed\"}" $DISCORD_WEBHOOK_URL
      /bin/echo "Backups not complete!"
    fi
    RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup snapshots || true

    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-on

done