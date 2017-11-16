#!/usr/bin/env bash
DIR=$(dirname $0)

echo "checking config files"
function checkfiles() {
if [ ! -f $1 ]; then
  cp $2 $1
  echo ""
  echo "file created with default settings: $1"
fi
}
checkfiles "$DIR/config/default.conf" "$DIR/config-slash-default.conf.example"
checkfiles "$DIR/config/settings.php" "$DIR/config-slash-settings-d7.php.example"
checkfiles "$DIR/.env" "$DIR/dot-env.example"

HOSTMACHINE_IP="172.16.123.45"
. $DIR/.env
echo "creating loopback alias if needed"
sudo ifconfig lo0 alias $HOSTMACHINE_IP
echo "setting up local dns resolution if needed"
echo "nameserver $HOSTMACHINE_IP" | sudo tee /etc/resolver/dev > /dev/null

echo ""
echo "if any files were created with the default settings, you will need to customize them before this stack is usable"


