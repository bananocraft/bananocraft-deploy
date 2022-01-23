#!/bin/bash
set -x
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true

# https://github.com/restic/restic/issues/1450
echo "seeing if a previous snapshots of server $SERVER_NAME are stored and checking their validity"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup rebuild-index || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup prune || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check || true

echo "these are the versions backed up and available for restore for server $SERVER_NAME"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup unlock || true
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup snapshots || true

echo "done checking status of restore"