#!/bin/bash

echo -e '\nInstalling VLC media player\n'

sudo apt update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install vlc || if [ ${?} -gt 0 ]; then exit 1; fi
