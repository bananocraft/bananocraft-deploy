#!/bin/bash

echo "seeing if a previous snapshots of server $SERVER_NAME are stored and checking their validity"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check

echo "these are the versions backed up and available for restore for server $SERVER_NAME"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup snapshots

echo "done checking status of restore"