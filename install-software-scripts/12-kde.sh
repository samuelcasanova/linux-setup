#!/bin/bash

echo -e '\nConfiguring KDE\n'

mkdir -p /tmp/kde/.config || if [ ${?} -gt 0 ]; then exit 1; fi

if [ -f ~/.config/discoverrc ]; then mv ~/.config/discoverrc /tmp/kde/.config; fi
if [ -f ~/.config/dolphinrc ]; then mv ~/.config/dolphinrc /tmp/kde/.config; fi
if [ -f ~/.config/kdeglobals ]; then mv ~/.config/kdeglobals /tmp/kde/.config; fi
if [ -f ~/.config/kglobalshortcutsrc ]; then mv ~/.config/kglobalshortcutsrc /tmp/kde/.config; fi
if [ -f ~/.config/konsolerc ]; then mv ~/.config/konsolerc /tmp/kde/.config; fi
if [ -f ~/.config/konsolesshconfig ]; then mv ~/.config/konsolesshconfig /tmp/kde/.config; fi
if [ -f ~/.config/plasmarc ]; then mv ~/.config/plasmarc /tmp/kde/.config; fi
if [ -d ~/.config/xsettingsd ]; then mv ~/.config/xsettingsd /tmp/kde/.config; fi
if [ -f ~/.config/ksmserverrc ]; then mv ~/.config/ksmserverrc /tmp/kde/.config; fi
if [ -f ~/.config/kwinrc ]; then mv ~/.config/kwinrc /tmp/kde/.config; fi
if [ -f ~/.config/kscreenlockerrc ]; then mv ~/.config/kscreenlockerrc /tmp/kde/.config; fi
if [ -f ~/.config/klipperrc ]; then mv ~/.config/klipperrc /tmp/kde/.config; fi
if [ -d ~/.local/share/konsole ]; then mv ~/.local/share/konsole /tmp/kde; fi

stow  -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ kde || if [ ${?} -gt 0 ]; then exit 1; fi
