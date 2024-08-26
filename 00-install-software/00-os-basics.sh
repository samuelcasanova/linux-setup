#!/bin/bash

echo -e '\nInstalling basic OS software\n'

#GRUB2 Theme
#https://k1ng.dev/distro-grub-themes/installation#manual-installation
echo -e 'Installing GRUB2\n'
sudo mkdir /boot/grub2/themes
sudo mkdir /boot/grub2/themes/fedora
wget -O /tmp/fedora.tar https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/fedora.tar
sudo tar -C /boot/grub2/themes/fedora -xf /tmp/fedora.tar
if sudo grep -q GRUB_GFXMODE /etc/default/grub; then
    sudo sed -i 's/GRUB_GFXMODE=[0-9]\+x[0-9]\+/GRUB_GFXMODE=1280x800/' /etc/default/grub
else
    echo 'GRUB_GFXMODE=1280x800' | sudo tee -a /etc/default/grub
fi
sudo sed -i 's/GRUB_TERMINAL_OUTPUT/#GRUB_TERMINAL_OUTPUT/' /etc/default/grub
echo 'GRUB_THEME="/boot/grub2/themes/fedora/theme.txt"' | sudo tee -a /etc/default/grub
sudo grub2-mkconfig -o /boot/grub2/grub.cfg

#Stow
sudo dnf install stow

#Google Chrome
echo -e 'Installing Chrome\n'
sudo dnf install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install google-chrome-stable

#KeepassXC
echo -e 'Installing KeepassXC\n'
sudo dnf install keepassxc

#RClone (to be configured with Onedrive)
echo -e 'Installing Rclone\n'
sudo dnf install rclone

#VS Code
echo -e 'Installing VS Code                 \n'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
