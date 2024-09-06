#!/bin/bash

echo -e '\nInstalling and configuring Wireguard for Immfly VPN\n'

sudo apt-get -y install wireguard-tools || if [ ${?} -gt 0 ]; then exit 1; fi
sudo cp ~/git/linux-setup-private/wireguard/wg1.conf /etc/wireguard/ || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e 'Installing the systemd service to initialize on each reboot\n'
if [ -f /etc/systemd/system/wireguard.service ]; then sudo mv /etc/systemd/system/wireguard.service /tmp; fi
#The systemctl enable fails if the next cp is changed to a ln -s
sudo cp ~/git/linux-setup/install-software-scripts/support-files/wireguard.service /etc/systemd/system/wireguard.service || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl start wireguard || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl enable wireguard.service || if [ ${?} -gt 0 ]; then exit 1; fi