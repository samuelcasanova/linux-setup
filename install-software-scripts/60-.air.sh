#!/bin/bash

echo -e '\nInstalling .air air-shopping dependencies\n'

# Imagemagick v7.1 already installed in Fedora
sudo dnf install -y tini
sudo dnf install -y httpd-tools # As apache2-utils is not available, I install httpd-tools that also contains ab benchmark tool needed for air-shopping tests

echo -e '\nInstalling air-local\n'

mkdir -p ~/git/iag
pushd ~/git/iag
git clone git@gitlab.com:iag-connect/tools/air-local.git
pushd air-local
echo -e "TAIL=0G-IFSC\nCAPTCHA_BYPASS=false" > ./.env
sed 's/0G-IFXX/0G-IFSC/g' ./projects/air-simulator/.env
echo "TAIL_NUMBER=0G-IFSC" > ./projects/air-rabbitmq-proxy/.env
./air-local init
popd
popd