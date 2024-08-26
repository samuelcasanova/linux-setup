#!/bin/bash

echo -e '\nConfiguring SSH\n'

mv ~/.ssh /tmp
stow -n -v -d ~/git/linux-setup/dotfiles/ -t ~ ssh
