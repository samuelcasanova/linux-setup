#!/bin/bash

echo -e '\nConfiguring bash shell\n'

if [ -f ~/.bashrc ]; then mv ~/.bashrc /tmp; fi
if [ -f ~/.bash_env_vars ]; then mv ~/.bash_env_vars /tmp; fi

stow  -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ bash || if [ ${?} -gt 0 ]; then exit 1; fi
stow  -v -d ~/git/setups/linux-setup-private/dotfiles/ -t ~ bash || if [ ${?} -gt 0 ]; then exit 1; fi
