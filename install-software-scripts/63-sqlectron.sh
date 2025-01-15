#!/bin/bash

echo -e '\nInstalling SQLectron\n'

read -p 'Press Enter to open the download page. You will need to download the Linux DEB AMD64 package and copy the file location. You will be prompted for this download location in the next step.'
xdg-open https://github.com/sqlectron/sqlectron-gui/releases
read -p 'Paste the local file location and press ENTER: ' SQLECTRON_INSTALLER_PATH
sudo apt-get -y install ${SQLECTRON_INSTALLER_PATH} || if [ ${?} -gt 0 ]; then exit 1; fi


