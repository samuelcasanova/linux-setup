#!/bin/bash

echo -e '\nInstalling rclone with Onedrive\n'

#RClone (to be configured with Onedrive)
echo -e 'Installing Rclone\n'
sudo apt-get -y install rclone || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e 'Stowing the config file\n'
if [ -d ~/.config/rclone ]; then mv ~/.config/rclone /tmp; fi
stow -v -d ~/git/linux-setup-private/dotfiles/ -t ~ rclone || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e 'Installing the systemd service to initialize on each reboot\n'
mkdir -p ~/onedrive || if [ ${?} -gt 0 ]; then exit 1; fi
if [ -f /etc/systemd/system/rclonemount.service ]; then sudo mv /etc/systemd/system/rclonemount.service /tmp; fi
#The systemctl enable fails if the next cp is changed to a ln -s
sudo cp ~/git/linux-setup/install-software-scripts/support-files/rclonemount.service /etc/systemd/system/rclonemount.service
sudo systemctl start rclonemount || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl enable rclonemount.service || if [ ${?} -gt 0 ]; then exit 1; fi