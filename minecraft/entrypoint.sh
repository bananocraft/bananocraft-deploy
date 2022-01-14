#!/usr/bin/env bash
set -eE -o pipefail

export BANANODE_IP=$(getent hosts bananode | awk '{ print $1 }')

yglu config.yglu > config.yml

mkdir -p plugins/BananoEconomy

cp config.yml ./plugins/BananoEconomy/config.yml

source /start