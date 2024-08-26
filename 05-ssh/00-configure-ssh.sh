#!/bin/bash

echo -e '\nConfiguring SSH\n'

mv ~/.ssh /tmp
stow -v -d ~/git/linux-setup-private/dotfiles/ -t ~ ssh
