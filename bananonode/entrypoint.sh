#!/usr/bin/env bash
set -Ee -o pipefail

mkdir /root/BananoData

wget https://banano.steampoweredtaco.com/download/snapshot.ldb.gz -q --show-progress
gunzip snapshot.ldb.gz

mv snapshot.ldb /root/BananoData/data.ldb

echo "unzipped and copied snapshot... starting node"

exec /usr/bin/entry.sh bananode daemon -l