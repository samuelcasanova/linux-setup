#!/bin/bash

echo -e '\nConfiguring bash shell\n'

mv ~/.bashrc /tmp
stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ bash
