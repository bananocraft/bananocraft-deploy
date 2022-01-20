#!/bin/bash

echo "restoring from backup $RESTORE_VERSION"
RESTIC_PASSWORD=$RESTIC_PASSWORD | restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore $RESTORE_VERSION --target /data

touch /data/.restored