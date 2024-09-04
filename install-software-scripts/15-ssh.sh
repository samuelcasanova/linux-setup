#!/bin/bash

echo -e '\nConfiguring SSH\n'

if [ -d ~/.ssh ]; then mv ~/.ssh /tmp; fi
stow -v -d ~/git/linux-setup-private/dotfiles/ -t ~ ssh || if [ ${?} -gt 0 ]; then exit 1; fi
chmod 600 ~/git/linux-setup-private/dotfiles/ssh/.ssh/linux* || if [ ${?} -gt 0 ]; then exit 1; fi
chmod 600 ~/git/linux-setup-private/dotfiles/ssh/.ssh/id* || if [ ${?} -gt 0 ]; then exit 1; fi