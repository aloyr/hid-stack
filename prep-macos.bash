#!/usr/bin/env bash
HOSTMACHINE_IP="172.16.123.45"
echo "creating loopback alias if needed"
sudo ifconfig lo0 alias $HOSTMACHINE_IP
echo "setting up local dns resolution if needed"
echo "nameserver $HOSTMACHINE_IP" | sudo tee /etc/resolver/dev > /dev/null

