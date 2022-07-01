# bananocraft-deploy

# Minecraft Deploy

### Restoring from Backup
1. Open Akashlytics
2. Select the active deployment
3. Open the Shell tab
4. Paste the following command into the Shell command line:
### `nohup ./restore.sh`


Open Powershell

Cd akashdeploy

CTRL+C

CTRL+R

docker run -e AKT_WALLET_SEED="<yourseed>" -e TEMP_WALLET_PASSWORD=<yourtemppass> --user root -it akashcli bash

akash tx cert generate client --from $AKASH_KEY_NAME

akash tx cert publish client --from $AKASH_KEY_NAME --gas-prices="0.025uakt" --gas="auto" --gas-adjustment=1.15

Not working? Run the next until forbole

export AKASH_NODE="$(curl -s "$AKASH_NET/rpc-nodes.txt" | shuf -n 1)" && echo $AKASH_NODE

akash provider lease-shell --tty --stdin --from $AKASH_KEY_NAME --dseq 5178886 --provider akash1vky0uh4wayh9npd74uqesglpaxwymynnspf6a4 -- web bash

Grab provider and dseq from akashlytics->raw data

akash provider lease-shell --tty --stdin --from $AKASH_KEY_NAME --dseq 5178886 --provider akash1vky0uh4wayh9npd74uqesglpaxwymynnspf6a4 -- web bash

If tmux not installed:

apt install tmux -y

Then open tmux

tmux


CTRL+B -> leader key
CTRL+B + " opens an horizontal split
CTRL+B + % opens vertical split

To restore from benis:
Go to https://pastebin.com/
Paste in the following:

#!/bin/bash

echo "restoring from backup $RESTORE_VERSION"
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --no-lock --repo rclone:bananocraft:bananocraftbackups/benis-backup unlock || true
mkdir /restorefiles
mkdir /restore
RESTIC_PASSWORD=$RESTIC_PASSWORD restic --repo rclone:bananocraft:bananocraftbackups/benis-backup restore $RESTORE_VERSION --target /restorefiles
rm -f /restorefiles/data/plugins/bananominer-*.jar
rm -f /restorefiles/data/plugins/EssentialsX-*.jar
rm -f /restorefiles/data/plugins/Geyser-Spigot.jar
sudo chown -R 1000:1000 /restorefiles
sudo chown -R 1000:1000 /data
zip -r /restore/restore.zip /restorefiles
rm -rf /restorefiles
export GENERIC_PACK=/restore/restore.zip

touch /data/.restored

Type:
vim myrestore.sh
