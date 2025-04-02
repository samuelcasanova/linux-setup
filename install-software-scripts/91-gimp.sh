#!/bin/bash

echo -e '\nInstalling GIMP\n'

sudo apt-get -y install gimp || if [ ${?} -gt 0 ]; then exit 1; fi
