#!/bin/bash

echo -e '\nInstalling Google Chrome\n'

#Google Chrome
echo -e 'Installing Chrome\n'
sudo apt install fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo apt install google-chrome-stable
