#!/bin/bash

echo -e '\nInstalling youtube music client with no ads\n'

read -p 'Press ENTER to open the downloads page and download the latest RPM available. You should copy the local path to the downloaded file.'
xdg-open https://github.com/th-ch/youtube-music/releases
read -p 'Paste the current local path to the RPM file: ' RPM_LOCAL_PATH
wget -qO- "https://raw.githubusercontent.com/nvm-sh/nvm/v${RPM_LOCAL_PATH}/install.sh" | bash

sudo apt install "${RPM_LOCAL_PATH}"
