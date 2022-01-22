#!/bin/bash
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock

# https://github.com/restic/restic/issues/1450
echo "seeing if a previous snapshots of server $SERVER_NAME are stored and checking their validity"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup rebuild-index
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup prune
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check

echo "these are the versions backed up and available for restore for server $SERVER_NAME"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup snapshots

echo "done checking status of restore"