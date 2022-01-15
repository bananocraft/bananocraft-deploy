#!/bin/bash
set -eE -o pipefail

echo "== Cloning Banano Node Monitor"
rm -rf /var/www/html/*
git clone https://github.com/BananoTools/bananoNodeMonitor.git /var/www/html/.

echo "== Adding config file"
cp ./config.php /var/www/html/modules/config.php

echo "all done ... node monitor running!"

source /etc/apache2/envvars
exec apache2 -D FOREGROUND

tail -F /var/log/apache2/*