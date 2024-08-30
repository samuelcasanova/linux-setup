#!/bin/bash

echo -e '\nInstalling KeePassXC\n'

#KeepassXC
echo -e 'Installing KeepassXC\n'
sudo dnf install -y keepassxc
mv ~/.config/KeePass /tmp
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ keepass

