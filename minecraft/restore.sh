#!/bin/bash

echo "restoring from last valid backup"
RESTIC_PASSWORD=$RESTIC_PASSWORD | restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore $RESTORE_VERSION --target /data

touch /data/.restored

reboot