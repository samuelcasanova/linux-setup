#!/bin/bash

echo -e '\nInstalling Google Chrome\n'

#Google Chrome
echo -e 'Installing Chrome\n'
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i /tmp/chrome.deb

