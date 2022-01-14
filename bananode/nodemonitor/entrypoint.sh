#!/bin/bash
set -eE -o pipefail

echo "== Cloning Banano Node Monitor"
rm -rf /var/www/html/*
git clone https://github.com/BananoTools/bananoNodeMonitor.git /var/www/html/.

if [ -f /opt/bananoNodeMonitor/modules/config.php ]; then

  echo "== Banano node directory exists, skipping initialization..."

else

  echo "== Creating monitor config"
  cp /var/www/html/modules/config.sample.php /var/www/html/modules/config.php

  echo "== Modifying the monitor config"

  # uncomment account
  sed -i -e 's#// $nanoNodeAccount#$nanoNodeAccount#g' /var/www/html/modules/config.php

  # replace account
  sed -i -e "s/xrb_1f56swb9qtpy3yoxiscq9799nerek153w43yjc9atoaeg3e91cc9zfr89ehj/$NODE_ACCOUNT/g" /var/www/html/modules/config.php

  # uncomment ip
  sed -i -e 's#// $nanoNodeRPCIP#$nanoNodeRPCIP#g' /var/www/html/modules/config.php

  # replace ip
  sed -i -e 's#\[::1\]#bananode#g' /var/www/html/modules/config.php

  # uncomment port
  sed -i -e 's#// $nanoNodeRPCPort#$nanoNodeRPCPort#g' /var/www/html/modules/config.php

  # replace port
  sed -i -e 's#7076#7072#g' /var/www/html/modules/config.php

fi

echo "all done ... node monitor running!"

source /etc/apache2/envvars
exec apache2 -D FOREGROUND

tail -F /var/log/apache2/*