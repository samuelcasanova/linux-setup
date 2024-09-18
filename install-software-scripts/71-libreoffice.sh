#!/bin/bash

echo -e '\nInstalling LibreOffice\n'

sudo apt-get -y install libreoffice || if [ ${?} -gt 0 ]; then exit 1; fi

