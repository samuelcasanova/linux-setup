#!/bin/bash

echo -e '\nInstalling Google Chrome\n'

#Google Chrome
echo -e 'Installing Chrome\n'
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable
