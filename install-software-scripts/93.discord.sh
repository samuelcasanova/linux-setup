#!/bin/bash

echo -e '\nInstalling Discord\n'

wget -O /tmp/discord.deb "https://discord.com/api/download?platform=linux&format=deb" || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install /tmp/discord.deb || if [ ${?} -gt 0 ]; then exit 1; fi
