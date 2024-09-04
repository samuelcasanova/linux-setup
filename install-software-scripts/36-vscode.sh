#!/bin/bash

echo -e '\nInstalling VS Code\n'

#VS Code
echo -e 'Installing VS Code\n'
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc || if [ ${?} -gt 0 ]; then exit 1; fi
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo' || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt install code || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nInstalling VS Code extensions\n'
code --install-extension Orta.vscode-jest || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension dbaeumer.vscode-eslint || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension esbenp.prettier-vscode || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension nicoespeon.abracadabra || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension SonarSource.sonarlint-vscode || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension VisualStudioExptTeam.vscodeintellicode || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension eamodio.gitlens || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension smcpeak.default-keys-windows || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nStowing VS Code dotfiles\n'
mkdir -p /tmp/vscode
if [ -f ~/.config/Code/User/keybindings.json ]; then mv ~/.config/Code/User/keybindings.json /tmp/vscode; fi
if [ -f ~/.config/Code/User/settings.json ]; then mv ~/.config/Code/User/settings.json /tmp/vscode; fi
if [ -d ~/.config/Code/User/snippets ]; then mv ~/.config/Code/User/snippets /tmp/vscode; fi
stow -v -d ~/git/linux-setup/dotfiles/ -t ~ vscode || if [ ${?} -gt 0 ]; then exit 1; fi
