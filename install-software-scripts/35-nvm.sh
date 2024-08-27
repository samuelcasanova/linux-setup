#!/bin/bash

echo -e '\nInstalling NVM and Node versions\n'

read -p 'Press ENTER to open the install instructions on your default browser. You should copy the current version (i.e. 0.40.0) and go back to this script.'
xdg-open https://github.com/nvm-sh/nvm?tab=readme-ov-file#installing-and-updating
read -p 'Paste the current NVM version (i.e. 0.40.0): ' NVM_VERSION
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${NVM_VERSION}/install.sh" | bash
source ~/.bashrc

nvm install v22
nvm install v20
nvm install v18
nvm install v16
nvm install v10
nvm install v8.4.0