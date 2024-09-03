#!/bin/bash

echo -e '\nInstalling KeePassXC\n'

#KeepassXC
echo -e 'Installing KeepassXC\n'
sudo apt install keepassxc
if [ -d KeePass ]; then mv ~/.config/KeePass /tmp; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ keepass

