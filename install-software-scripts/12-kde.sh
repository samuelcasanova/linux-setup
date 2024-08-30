#!/bin/bash

echo -e '\nConfiguring KDE\n'

mkdir -p /tmp/.config

mv ~/.config/discoverrc /tmp/.config
mv ~/.config/dolphinrc /tmp/.config
mv ~/.config/kdeglobals /tmp/.config
mv ~/.config/kglobalshortcutsrc /tmp/.config
mv ~/.config/konsolerc /tmp/.config
mv ~/.config/konsolesshconfig /tmp/.config
mv ~/.config/plasmarc /tmp/.config
mv ~/.config/xsettingsd /tmp/.config
mv ~/.config/ksmserverrc /tmp/.config

stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ kde
