#!/bin/bash

echo -e '\nInstalling Google Chrome\n'

#Google Chrome
echo -e 'Installing Chrome\n'
sudo apt install google-chrome-stable || if [ ${?} -gt 0 ]; then exit 1; fi
