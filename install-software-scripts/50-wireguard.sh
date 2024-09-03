#!/bin/bash

echo -e '\nInstalling and configuring Wireguard for Immfly VPN\n'

sudo apt install wireguard-tools
sudo cp ~/git/linux-setup-private/wireguard/wg1.conf /etc/wireguard/

echo -e 'Installing the systemd service to initialize on each reboot\n'
if [ -f /etc/systemd/system/wireguard.service ]; then sudo mv /etc/systemd/system/wireguard.service /tmp; fi
#The systemctl enable fails if the next cp is changed to a ln -s
sudo cp ~/git/linux-setup/install-software-scripts/support-files/wireguard.service /etc/systemd/system/wireguard.service
sudo systemctl start wireguard
sudo systemctl enable wireguard.service