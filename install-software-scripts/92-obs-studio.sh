#!/bin/bash

echo -e '\nInstalling OBS studio\n'

sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt-get -y install obs-studio || if [ ${?} -gt 0 ]; then exit 1; fi
