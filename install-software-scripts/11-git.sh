#!/bin/bash

echo -e '\nConfiguring git\n'

if [ -f ~/.gitconfig ]; then mv ~/.gitconfig /tmp; fi
stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ git
