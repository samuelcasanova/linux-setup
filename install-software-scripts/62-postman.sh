#!/bin/bash

echo -e '\nInstalling Postman\n'

wget -O /tmp/postman.tar.gz https://dl.pstmn.io/download/latest/linux64 || if [ ${?} -gt 0 ]; then exit 1; fi
mkdir -p /tmp/postman
tar -C /tmp/postman -zxf /tmp/postman.tar.gz
sudo mv /tmp/postman/Postman /opt
sudo cp ~/git/setups/linux-setup/install-software-scripts/support-files/postman.desktop /usr/share/applications/postman.desktop