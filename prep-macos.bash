#!/usr/bin/env bash
HOSTMACHINE_IP="172.16.123.45"
sudo ifconfig lo0 alias $HOSTMACHINE_IP
echo "nameserver $HOSTMACHINE_IP" | sudo tee /etc/resolver/dev

