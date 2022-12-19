#!/bin/bash

while true; do
  sleep $(($BACKUP_MINUTE_INTERVAL * 60))
  rm /data/.restored || true

  /bin/echo "Starting backup..."

  /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backing up server."
  curl -H "Content-Type: application/json" -d "{\"username\": \"bananocraftbot\", \"content\": \"Backing up bananocraft server ${SERVER_NAME}\"}" $DISCORD_WEBHOOK_URL
  /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-off
  /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-all

  sleep 10

  echo "running restic"
  #RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || EXIT_CODE=$?
  RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup init || true
  EXIT_CODE=0
  RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup backup /data || EXIT_CODE=$?
  if [ $EXIT_CODE -eq 0 ]; then
    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "say Backup complete!"
    curl -H "Content-Type: application/json" -d "{\"username\": \"bananocraftbot\", \"content\": \"Backup complete for ${SERVER_NAME}\"}" $DISCORD_WEBHOOK_URL
    /bin/echo "Backup complete!"
  else
    /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "Backups not complete. Notify mconstant#4986 on Discord to fix backups for ${SERVER_NAME}. Attempting to send discord webhook automatically."
    curl -H "Content-Type: application/json" -d "{\"username\": \"bananocraftbot\", \"content\": \"Backups on bananocraft server ${SERVER_NAME} need to be fixed\"}" $DISCORD_WEBHOOK_URL
    /bin/echo "Backups not complete!"
  fi

  /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" save-on

  RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup forget --keep-hourly 24 --keep-daily 7 --keep-weekly 5 --keep-monthly 12 --keep-yearly 75 --prune
  RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup snapshots > available_snapshots.txt
  curl -F "payload_json={\"username\": \"bananocraftbot\", \"content\": \"available snapshots for $SERVER_NAME\"}" -F "file1=@available_snapshots.txt" $DISCORD_WEBHOOK_URL
  /usr/local/bin/mcrcon -H localhost -P $RCON_PORT -p "$RCON_PASSWORD" "check #backupbot channel on bananocraft.cc Discord for a log of available snapshots"

done
