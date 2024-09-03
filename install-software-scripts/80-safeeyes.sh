#!/bin/bash

echo -e '\nInstalling safeeyes\n'

sudo dnf config-manager --add-repo https://copr.fedorainfracloud.org/coprs/alonid/xprintidle/repo/epel-7/alonid-xprintidle-epel-7.repo
sudo apt install libappindicator-gtk3 python3-psutil
sudo apt install python3-pip
sudo pip3 install safeeyes
sudo gtk-update-icon-cache /usr/share/icons/hicolor
if [ -d ~/.config/safeeyes ]; then mv ~/.config/safeeyes /tmp; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ safeeyes
