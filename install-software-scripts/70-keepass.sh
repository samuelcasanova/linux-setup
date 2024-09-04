#!/bin/bash

echo -e '\nInstalling KeePassXC\n'

#KeepassXC
echo -e 'Installing KeepassXC\n'
sudo apt install keepassxc || if [ ${?} -gt 0 ]; then exit 1; fi
if [ -d ~/.config/KeePass ]; then mv ~/.config/KeePass /tmp; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ keepass || if [ ${?} -gt 0 ]; then exit 1; fi

