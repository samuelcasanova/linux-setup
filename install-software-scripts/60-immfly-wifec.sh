#!/bin/bash

echo -e '\nInstalling Immfly wIFEC dependencies and projects\n'

mkdir -p ~/git/immfly
pushd ~/git/immfly/
echo -e '\nInstalling local environment (backend services)\n'
git clone git@git.immfly.com:immfly/local-environment.git || if [ ${?} -gt 0 ]; then exit 1; fi
~/git/setups/linux-setup-private/install-software-scripts/support-files/immfly-wifec/setup-wifec.sh || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/airside
pushd ~/git/immfly/airside
git clone git@git.immfly.com:immfly/ife-app.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/immfly-wifec/ife-app/.npmrc ~/git/immfly/airside/ife-app/.npmrc || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/voe-magazine.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/airside/air-services.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/flight-info.git flight-info-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/routes/service.git route-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/immfly-notifier.git immfly-notifier-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/routes/admin.git route-admin-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/flightinfo-adapter.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/aircraft.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/inventory/service.git inventory-service || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/charon-air.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/musement-api.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/groundside
pushd ~/git/immfly/groundside
git clone git@git.immfly.com:immfly/microservices/grd-vouchers.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/immfly/libs
pushd ~/git/immfly/libs
git clone git@git.immfly.com:immfly/microservices/lib-python.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/microservices/contrib/sentry.git sentry-python-lib || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/devops-resources.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-amqp-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-config-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-couchdb-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-logging-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-dependency-injection-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-error-tracking-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-events-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-http-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@git.immfly.com:immfly/shared/node-shared-types-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
popd

sudo apt-get -y install make || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nConfiguring Immfly docker registry in local...\n'
if [ -f ~/.docker/config.json ]; then mv ~/.docker/config.json /tmp; fi
ln -s ~/git/setups/linux-setup-private/dotfiles/docker/config.json ~/.docker/config.json || if [ ${?} -gt 0 ]; then exit 1; fi
