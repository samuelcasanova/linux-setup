#!/bin/bash

echo -e '\nInstalling Okular PDF viewer\n'

sudo apt-get -y install okular || if [ ${?} -gt 0 ]; then exit 1; fi

