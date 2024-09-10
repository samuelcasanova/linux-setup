#!/bin/bash

echo -e '\nInstalling KeePassXC\n'

#KeepassXC
echo -e 'Installing KeepassXC\n'
sudo apt-get -y install keepassxc || if [ ${?} -gt 0 ]; then exit 1; fi
if [ -d ~/.config/keepassxc ]; then mv ~/.config/keepassxc /tmp; fi
if [ -f ~/.config/KeePassXCrc ]; then mv ~/.config/KeePassXCrc /tmp; fi
stow -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ keepass || if [ ${?} -gt 0 ]; then exit 1; fi

