#!/bin/bash

echo -e '\nInstalling .air air-shopping dependencies\n'

# Imagemagick v7.1 already installed in Fedora
sudo apt install tini || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt install apache2-utils || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nInstalling air-local\n'

mkdir -p ~/git/iag
pushd ~/git/iag
git clone git@gitlab.com:iag-connect/tools/air-local.git || if [ ${?} -gt 0 ]; then exit 1; fi
pushd air-local
echo -e "TAIL=0G-IFSC\nCAPTCHA_BYPASS=false" > ./.env || if [ ${?} -gt 0 ]; then exit 1; fi
sed 's/0G-IFXX/0G-IFSC/g' ./projects/air-simulator/.env || if [ ${?} -gt 0 ]; then exit 1; fi
echo "TAIL_NUMBER=0G-IFSC" > ./projects/air-rabbitmq-proxy/.env || if [ ${?} -gt 0 ]; then exit 1; fi
./air-local init || if [ ${?} -gt 0 ]; then exit 1; fi
popd
popd