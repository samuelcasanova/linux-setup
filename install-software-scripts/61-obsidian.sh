#!/bin/bash

echo -e '\nInstalling Obsidian\n'

read -p 'Press Enter to open the download page. You will need to download the Linux DEB x64 package and copy the file location. You will be prompted for this download location in the next step.'
xdg-open https://obsidian.md/download
read -p 'Paste the local file location and press ENTER: ' OBSIDIAN_INSTALLER_PATH
sudo apt-get -y install ${OBSIDIAN_INSTALLER_PATH} || if [ ${?} -gt 0 ]; then exit 1; fi

pushd ~/git
git clone git@github.com:samuelcasanova/secondbrain.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd
echo -e 'Now open the Obsidian app and configure the vault pointint to ~/git/secondbrain'
echo -e 'Make sure you have installed and enable the following plugins: emoji shortcodes, file hider and Git (with backup and pull intervals to 1 minute)'
