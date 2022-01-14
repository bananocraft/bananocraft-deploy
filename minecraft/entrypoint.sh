#!/usr/bin/env bash
set -eE -o pipefail

yglu config.yglu > config.yml

cat config.yml

#cp BananoEconomy-1.0-SNAPSHOT.jar ./plugins/BananoEconomy-1.0-SNAPSHOT.jar
#cp craftbukkit-1.18.jar ./plugins/craftbukkit-1.18.jar

source /start