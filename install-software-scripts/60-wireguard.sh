#!/bin/bash

echo -e '\nInstalling and configuring Wireguard for Immfly VPN\n'

sudo dnf install wireguard-tools
sudo cp ~/git/linux-setup-private/wireguard/wg1.conf /etc/wireguard/
./support-files/setvpn.sh up