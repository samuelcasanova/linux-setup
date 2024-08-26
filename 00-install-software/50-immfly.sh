#!/bin/bash

PRIVATE_REPO=~/git/linux-setup-private

echo -e '\nInstalling Immfly mandatory software to work\n'

echo -e 'Installing wireguard\n'
sudo dnf install wireguard-tools
sudo cp ${PRIVATE_REPO}/wireguard/wg1.conf /etc/wireguard/
./setvpn.sh up