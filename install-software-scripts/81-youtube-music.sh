#!/bin/bash

echo -e '\nInstalling youtube music client with no ads\n'

read -p 'Press ENTER to open the downloads page and download the latest DEB available. You should copy the local path to the downloaded file.'
xdg-open https://github.com/th-ch/youtube-music/releases
read -p 'Paste the current local path to the DEB file: ' DEB_LOCAL_PATH
sudo apt-get -y install "${DEB_LOCAL_PATH}" || if [ ${?} -gt 0 ]; then exit 1; fi
sudo sed -i 's/\%U$/--no-sandbox \%U/g' /usr/share/applications/youtube-music.desktop || if [ ${?} -gt 0 ]; then exit 1; fi