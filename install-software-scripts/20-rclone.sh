#!/bin/bash

echo -e '\nInstalling rclone with Onedrive\n'

#RClone (to be configured with Onedrive)
echo -e 'Installing Rclone\n'
sudo dnf install rclone

echo -e 'Stowing the config file\n'
mv ~/.config/rclone /tmp
stow -v -d ~/git/linux-setup-private/dotfiles/ -t ~ rclone

echo -e 'Installing the systemd service to initialize on each reboot\n'
sudo mv /etc/systemd/system/rclonemount.service /tmp
#The systemctl enable fails if the next cp is changed to a ln -s
sudo cp ~/git/linux-setup/install-software-scripts/support-files/rclonemount.service /etc/systemd/system/rclonemount.service
sudo systemctl start rclonemount
sudo systemctl enable rclonemount.service