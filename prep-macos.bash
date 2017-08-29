#!/usr/bin/env bash
HOSTMACHINE_IP="172.16.123.45"
echo "creating loopback alias if needed"
sudo ifconfig lo0 alias $HOSTMACHINE_IP
echo "setting up local dns resolution if needed"
echo "nameserver $HOSTMACHINE_IP" | sudo tee /etc/resolver/dev > /dev/null
echo "checking config files"
function checkfiles() {
if [ ! -f $2 ]; then
  cp $1 $2
  echo ""
  echo "file created with default settings: $1"
fi
}
checkfiles "config/default.conf" "config-slash-default.conf.example"
checkfiles "config/settings.php" "config-slash-settings-d7.php.example"
checkfiles ".env" "dot-env.example"

echo ""
echo "if any files were created with the default settings, you will need to customize them before this stack is usable"


