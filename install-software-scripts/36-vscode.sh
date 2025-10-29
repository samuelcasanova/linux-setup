#!/bin/bash

echo -e '\nInstalling VS Code\n'

#VS Code
echo -e 'Installing VS Code\n'
sudo apt update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install software-properties-common apt-transport-https wget -y || if [ ${?} -gt 0 ]; then exit 1; fi
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add - || if [ ${?} -gt 0 ]; then exit 1; fi
sudo add-apt-repository -y "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install code || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nInstalling VS Code extensions\n'
code --install-extension Orta.vscode-jest || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension dbaeumer.vscode-eslint || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension esbenp.prettier-vscode || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension nicoespeon.abracadabra || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension SonarSource.sonarlint-vscode || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension eamodio.gitlens || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension smcpeak.default-keys-windows || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension GitLab.gitlab-workflow || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension pkief.material-icon-theme || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension usernamehw.errorlens || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension ms-python.python || if [ ${?} -gt 0 ]; then exit 1; fi
code --install-extension ms-python.flake8 || if [ ${?} -gt 0 ]; then exit 1; fi


echo -e '\nStowing VS Code dotfiles\n'
mkdir -p /tmp/vscode
if [ -f ~/.config/Code/User/keybindings.json ]; then mv ~/.config/Code/User/keybindings.json /tmp/vscode; fi
if [ -f ~/.config/Code/User/settings.json ]; then mv ~/.config/Code/User/settings.json /tmp/vscode; fi
if [ -d ~/.config/Code/User/snippets ]; then mv ~/.config/Code/User/snippets /tmp/vscode; fi
stow -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ vscode || if [ ${?} -gt 0 ]; then exit 1; fi
