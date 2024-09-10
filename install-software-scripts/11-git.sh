#!/bin/bash

echo -e '\nConfiguring git\n'

if [ -f ~/.gitconfig ]; then mv ~/.gitconfig /tmp; fi
stow  -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ git || if [ ${?} -gt 0 ]; then exit 1; fi
