#!/bin/bash

echo -e '\nConfiguring bash shell\n'

if [ -f ~/.bashrc ]; then mv ~/.bashrc /tmp; fi
stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ bash || if [ ${?} -gt 0 ]; then exit 1; fi
