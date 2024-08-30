#!/bin/bash

echo -e '\nInstalling safeeyes\n'

sudo dnf config-manager --add-repo https://copr.fedorainfracloud.org/coprs/alonid/xprintidle/repo/epel-7/alonid-xprintidle-epel-7.repo
sudo dnf install -y libappindicator-gtk3 python3-psutil
sudo dnf install -y python3-pip
sudo pip3 install safeeyes
sudo gtk-update-icon-cache /usr/share/icons/hicolor




