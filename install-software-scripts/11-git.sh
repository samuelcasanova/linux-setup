#!/bin/bash

echo -e '\nConfiguring git\n'

if [ -f ~/.gitconfig ]; then mv ~/.gitconfig /tmp; fi
stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ git || if [ ${?} -gt 0 ]; then exit 1; fi
