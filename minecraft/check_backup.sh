#!/bin/bash

echo "seeing if any previous snapshots of this server are stored and checking their validity"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check

echo "done checking status of restore"