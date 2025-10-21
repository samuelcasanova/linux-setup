#!/bin/bash

echo -e '\nInstalling Immfly wIFEC dependencies and projects\n'

mkdir -p ~/git/immfly
pushd ~/git/immfly

echo -e '\nInstalling local environment (backend services)\n'
git clone git@git.immfly.com:immfly/local-environment.git || if [ ${?} -gt 0 ]; then exit 1; fi
~/git/setups/linux-setup-private/install-software-scripts/support-files/immfly-wifec/setup-wifec.sh || if [ ${?} -gt 0 ]; then exit 1; fi

git clone git@git.immfly.com:immfly/ife-app.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/immfly-wifec/ife-app/.npmrc ~/git/immfly/ife-app/.npmrc || if [ ${?} -gt 0 ]; then exit 1; fi

sudo apt-get -y install make || if [ ${?} -gt 0 ]; then exit 1; fi