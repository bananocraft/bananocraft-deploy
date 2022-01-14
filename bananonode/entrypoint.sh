#!/usr/bin/env bash
set -Ee -o pipefail

mkdir /root/BananoData

curl https://banano.steampoweredtaco.com/download/snapshot.ldb.gz -o snapshot.ldb.gz

gunzip snapshot.ldb.gz

mv snapshot.ldb /root/BananoData/data.ldb

echo "unzipped and copied snapshot... starting node"

eval /usr/bin/entry.sh bananode daemon -l