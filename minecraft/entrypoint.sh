#!/usr/bin/env bash
set -eE -o pipefail

yglu config.yglu > config.yml
yglu bananominerconfig.yglu > bananominerconfig.yml
yglu bananosuiteconfig.yglu > bananosuiteconfig.yml
yglu bananochestsconfig.yglu > bananochestsconfig.yml
yglu geyserconfig.yglu > geyserconfig.yml
yglu petshopconfig.yglu > petshopconfig.yml
yglu pvptoggle.yglu > pvptoggle.yml

mkdir -p plugins/BananoEconomy
mkdir -p plugins/BananoMiner
mkdir -p plugins/Vault
mkdir -p plugins/Geyser-Spigot
mkdir -p plugins/PetShop
mkdir -p plugins/BananoSuite
mkdir -p plugins/PvPToggle

cp config.yml ./plugins/BananoEconomy/config.yml
cp bananominerconfig.yml ./plugins/BananoMiner/config.yml
cp bananosuiteconfig.yml ./plugins/BananoSuite/config.yml
cp bananochestsconfig.yml ./plugins/BananoChests/config.yml
cp geyserconfig.yml ./plugins/Geyser-Spigot/config.yml
cp petshopconfig.yml ./plugins/PetShop/config.yml
cp pvptoggle.yml ./plugins/PvPToggle/config.yml

if [ "$CHECK_BACKUP" = true ] ; then
  source /data/check_backup.sh
fi

if [ ! -f /data/.restored ] ; then
  if [ "$RESTORE_FROM_BACKUP" = true ] ; then
    source /data/restore.sh
  fi
fi

source /data/backup.sh &

source /start &

tail -f /dev/null