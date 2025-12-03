#!/bin/bash

echo -e '\nInstalling Pinta\n'

wget https://launchpad.net/~xtradeb/+archive/ubuntu/apps/+files/xtradeb-apt-source_0.4_all.deb || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt install ./xtradeb-apt-source_0.4_all.deb || if [ ${?} -gt 0 ]; then exit 1; fi
rm ./xtradeb-apt-source_0.4_all.deb || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt install libadwaita-1-0 || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install pinta || if [ ${?} -gt 0 ]; then exit 1; fi
