#!/bin/bash

echo -e '\nInstalling safeeyes\n'

sudo add-apt-repository ppa:safeeyes-team/safeeyes || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install safeeyes || if [ ${?} -gt 0 ]; then exit 1; fi

if [ -d ~/.config/safeeyes ]; then mv ~/.config/safeeyes /tmp; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ safeeyes || if [ ${?} -gt 0 ]; then exit 1; fi
