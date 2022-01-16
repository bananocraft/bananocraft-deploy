#!/usr/bin/env bash
set -eE -o pipefail

yglu config.yglu > config.yml

mkdir -p plugins/BananoEconomy

cp config.yml ./plugins/BananoEconomy/config.yml

source /start