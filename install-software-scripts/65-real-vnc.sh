#!/bin/bash

echo -e '\nInstalling Real VNC Viewer\n'

read -p 'Press Enter to open the download page. You will need to download the Linux RPM x64 package and copy the file location. You will be prompted for this download location in the next step.'
xdg-open https://www.realvnc.com/en/connect/download/viewer/linux/
read -p 'Paste the local file location and press ENTER: ' REALVNC_INSTALLER_PATH
sudo dnf install -y ${REALVNC_INSTALLER_PATH}

mv ~/.vnc /tmp
stow  -v -d ~/git/linux-setup-private/dotfiles/ -t ~ realvnc