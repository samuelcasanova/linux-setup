#!/bin/bash

echo -e '\nInstalling VS Code\n'

#VS Code
echo -e 'Installing VS Code\n'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo apt install code

echo -e '\nInstalling VS Code extensions\n'
code --install-extension Orta.vscode-jest
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension nicoespeon.abracadabra
code --install-extension SonarSource.sonarlint-vscode
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension eamodio.gitlens
code --install-extension smcpeak.default-keys-windows

echo -e '\nStowing VS Code dotfiles\n'
mkdir -p /tmp/vscode
if [ -f ~/.config/Code/User/keybindings.json ]; then mv ~/.config/Code/User/keybindings.json /tmp/vscode; fi
if [ -f ~/.config/Code/User/settings.json ]; then mv ~/.config/Code/User/settings.json /tmp/vscode; fi
if [ -d ~/.config/Code/User/snippets ]; then mv ~/.config/Code/User/snippets /tmp/vscode; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ vscode
