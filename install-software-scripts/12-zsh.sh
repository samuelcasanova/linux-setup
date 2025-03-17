#!/bin/bash

echo -e '\nConfiguring zsh\n'

sudo apt-get -y install zsh || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install fzf || if [ ${?} -gt 0 ]; then exit 1; fi
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" || if [ ${?} -gt 0 ]; then exit 1; fi

pushd ~/.oh-my-zsh/plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone https://github.com/zsh-users/zsh-autosuggestions.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

if [ -f ~/.zshrc ]; then mv ~/.zshrc /tmp; fi

stow  -v -d ~/git/setups/linux-setup/dotfiles/ -t ~ zsh || if [ ${?} -gt 0 ]; then exit 1; fi
