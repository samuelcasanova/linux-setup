#!/bin/bash

echo -e '\nInstalling safeeyes\n'

echo 'ÇCheck instructions for debian'
exit 1

sudo apt install libappindicator-gtk3 python3-psutil || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt install python3-pip || if [ ${?} -gt 0 ]; then exit 1; fi
sudo pip3 install safeeyes || if [ ${?} -gt 0 ]; then exit 1; fi
sudo gtk-update-icon-cache /usr/share/icons/hicolor || if [ ${?} -gt 0 ]; then exit 1; fi
if [ -d ~/.config/safeeyes ]; then mv ~/.config/safeeyes /tmp; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ safeeyes || if [ ${?} -gt 0 ]; then exit 1; fi
