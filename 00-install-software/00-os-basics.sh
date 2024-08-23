#!/bin/bash

echo 'Installing basic OS software'

INSTALLER_COMMAND='sudo dnf install'

#Google Chrome
${INSTALLER_COMMAND} fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
${INSTALLER_COMMAND} google-chrome-stable

#KeepassXC
${INSTALLER_COMMAND} keepassxc

#RClone (to be configured with Onedrive)
${INSTALLER_COMMAND} rclone

#Git
${INSTALLER_COMMAND} git

#VS Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install code
