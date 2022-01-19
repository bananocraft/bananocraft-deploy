#!/usr/bin/env bash
set -eE -o pipefail

yglu config.yglu > config.yml

mkdir -p plugins/BananoEconomy

cp config.yml ./plugins/BananoEconomy/config.yml

service cron start

if [ "CHECK_BACKUP" = true ] ; then
  source /data/check_backup.sh
fi

if [ ! -f /data/.restored] ; then
  if [ "$RESTORE_FROM_BACKUP" = true ] ; then
    source /data/restore.sh
  fi
fi

source /start