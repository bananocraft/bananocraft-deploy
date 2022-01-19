#!/bin/bash

echo "restoring from last valid backup"
yes $RESTIC_PASSWORD | restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore $RESTORE_VERSION --target /data

touch /data/.restored

reboot