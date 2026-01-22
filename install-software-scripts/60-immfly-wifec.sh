#!/bin/bash

echo -e '\nInstalling Immfly wIFEC dependencies and projects\n'

mkdir -p ~/git/immfly
pushd ~/git/immfly/
echo -e '\nInstalling local environment (backend services)\n'
git clone git@git.immfly.com:immfly/local-environment.git || if [ ${?} -gt 0 ]; then exit 1; fi
~/git/setups/linux-setup-private/install-software-scripts/support-files/immfly-wifec/setup-wifec.sh || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/frontend
pushd ~/git/immfly/frontend
git clone git@git.immfly.com:immfly/ife-app.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/immfly-wifec/ife-app/.npmrc ~/git/immfly/ife-app/.npmrc || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/voe-magazine.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/backend
pushd ~/git/immfly/backend
git clone git@git.immfly.com:immfly/microservices/routes/service.git route-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/flight-info.git flight-info-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/immfly-notifier.git immfly-notifier-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/routes/admin.git route-admin-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/lib-python.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/flightinfo-adapter.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/inventory/service.git inventory-service || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/backoffice
pushd ~/git/immfly/backoffice
git clone git@git.immfly.com:immfly/aircraft.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

sudo apt-get -y install make || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nConfiguring Immfly docker registry in local...\n'
if [ -d ~/.docker ]; then mv ~/.docker /tmp; fi
stow -v -d ~/git/setups/linux-setup-private/dotfiles/ -t ~ docker || if [ ${?} -gt 0 ]; then exit 1; fi
