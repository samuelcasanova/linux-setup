#!/bin/bash

echo -e '\nInstalling VS Code\n'

#VS Code
echo -e 'Installing VS Code\n'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code


mv ~/.vscode /tmp
stow  -v -d ~/git/linux-setup/dotfiles/ -t ~ vscode
