#!/bin/bash

echo -e '\nConfiguring KDE\n'

mkdir -p /tmp/kde/.config

mv ~/.config/discoverrc /tmp/kde/.config
mv ~/.config/dolphinrc /tmp/kde/.config
mv ~/.config/kdeglobals /tmp/kde/.config
mv ~/.config/kglobalshortcutsrc /tmp/kde/.config
mv ~/.config/konsolerc /tmp/kde/.config
mv ~/.config/konsolesshconfig /tmp/kde/.config
mv ~/.config/plasmarc /tmp/kde/.config
mv ~/.config/xsettingsd /tmp/kde/.config
mv ~/.config/ksmserverrc /tmp/kde/.config
mv ~/.local/share/konsole /tmp/kde

stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ kde
