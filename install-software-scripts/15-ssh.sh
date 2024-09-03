#!/bin/bash

echo -e '\nConfiguring SSH\n'

if [ -d ~/.ssh ]; then mv ~/.ssh /tmp; fi
stow -v -d ~/git/linux-setup-private/dotfiles/ -t ~ ssh
chmod 600 ~/git/linux-setup-private/dotfiles/ssh/.ssh/linux*
chmod 600 ~/git/linux-setup-private/dotfiles/ssh/.ssh/id*