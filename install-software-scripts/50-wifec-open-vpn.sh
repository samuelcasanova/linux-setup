#!/bin/bash

echo -e '\nInstalling and configuring Immfly WIFEC VPN\n'

sudo apt-get -y install apt-transport-https curl || if [ ${?} -gt 0 ]; then exit 1; fi
mkdir -p /etc/apt/keyrings || if [ ${?} -gt 0 ]; then exit 1; fi
sudo sh -c "curl -sSfL https://packages.openvpn.net/packages-repo.gpg > /etc/apt/keyrings/openvpn.asc" || if [ ${?} -gt 0 ]; then exit 1; fi
sudo sh -c "echo 'deb [signed-by=/etc/apt/keyrings/openvpn.asc] https://packages.openvpn.net/openvpn3/debian noble main' >> /etc/apt/sources.list.d/openvpn3.list" || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install openvpn3 || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e 'Installing the systemd service to initialize on each reboot\n'
if [ -f /etc/systemd/system/wifecvpn.service ]; then sudo mv /etc/systemd/system/wifecvpn.service /tmp; fi
#The systemctl enable fails if the next cp is changed to a ln -s
sudo cp ~/git/setups/linux-setup/install-software-scripts/support-files/wifecvpn.service /etc/systemd/system/wifecvpn.service || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl start wifecvpn || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl enable wifecvpn.service || if [ ${?} -gt 0 ]; then exit 1; fi