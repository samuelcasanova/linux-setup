#!/bin/bash

echo -e '\nInstalling VS Code\n'

#VS Code
echo -e 'Installing VS Code\n'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf check-update
sudo dnf install -y code

echo -e '\nInstalling VS Code extensions\n'
code --install-extension Orta.vscode-jest
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode
code --install-extension nicoespeon.abracadabra
code --install-extension SonarSource.sonarlint-vscode
code --install-extension VisualStudioExptTeam.vscodeintellicode
code --install-extension eamodio.gitlens

echo -e '\nStowing VS Code dotfiles\n'
mkdir -p /tmp/vscode
mv ~/.config/Code/User/keybindings.json /tmp/vscode
mv ~/.config/Code/User/settings.json /tmp/vscode
mv ~/.config/Code/User/snippets /tmp/vscode
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ vscode
