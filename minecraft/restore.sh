#!/bin/bash

echo "seeing if any previous snapshots of this server are stored and checking their validity"
yes $RESTIC_PASSWORD | restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup check

retVal=${PIPESTATUS[1]}
if [ $retVal -ne 0 ]; then
    echo "No verified backup, not restoring"
else
    echo "restoring from last valid backup"
    yes $RESTIC_PASSWORD | restic --repo rclone:bananocraft:bananocraftbackups/${SERVER_NAME}-backup restore latest --target /data
fi
