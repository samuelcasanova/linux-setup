#!/bin/bash

echo -e '\nInstalling .air air-shopping dependencies\n'

# Imagemagick v7.1 already installed in Ubuntu
sudo apt-get -y install tini || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install apache2-utils || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install sshpass || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nInstalling air-local\n'

mkdir -p ~/git/iag
pushd ~/git/iag

git clone git@gitlab.com:iag-connect/tools/air-local.git || if [ ${?} -gt 0 ]; then exit 1; fi
pushd air-local
./air-local.sh init || if [ ${?} -gt 0 ]; then exit 1; fi
echo -e "TAIL=0G-IFSC\nCAPTCHA_BYPASS=false" > ./.env || if [ ${?} -gt 0 ]; then exit 1; fi
sed -i 's/0G-IFXX/0G-IFSC/g' ./projects/air-simulator/.env || if [ ${?} -gt 0 ]; then exit 1; fi
echo "TAIL_NUMBER=0G-IFSC" > ./projects/air-rabbitmq-proxy/.env || if [ ${?} -gt 0 ]; then exit 1; fi
./air-local.sh up -o baw -i gogo
mkdir -p ./projects/air-shopping/.vscode || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup/install-software-scripts/support-files/air-shopping-vscode/* ./projects/air-shopping/.vscode/ || if [ ${?} -gt 0 ]; then exit 1; fi
popd

mkdir -p ~/git/iag/qa
pushd ~/git/iag/qa

git clone git@gitlab.com:iag-connect/qa/iag-racks-smoke-tests.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/dot-air/iag-rack-smoke-tests.env.sh ~/git/iag/qa/iag-racks-smoke-tests/SmokeScripts/env.sh

git clone git@gitlab.com:iag-connect/qa/iag-automated-tests.git || if [ ${?} -gt 0 ]; then exit 1; fi
cd iag-automated-tests
. ~/.bashrc
nvm use
npm install -D @playwright/test@latest
npx playwright install --with-deps 
cp src/configs/local.example.config.ts src/configs/local.config.ts
cp src/configs/env/local/local.template.env src/configs/env/local/local.env
sed -i 's/0G-IFXX/0G-IFSC/g' src/configs/env/local/local.env || if [ ${?} -gt 0 ]; then exit 1; fi

git clone git@gitlab.com:iag-connect/qa/iag-rack-tools.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd

mkdir -p ~/git/iag/grd
pushd ~/git/iag/grd

git clone git@gitlab.com:iag-connect/groundside/grd-ota-data.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/dot-air/grd-ota-data.env ~/git/iag/grd/grd-ota-data/.env || if [ ${?} -gt 0 ]; then exit 1; fi

cp grd-ota-data/.env-template grd-ota-data/.env
git clone git@gitlab.com:iag-connect/groundside/grd-flight-data.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/grd-entitlements-v2.git || if [ ${?} -gt 0 ]; then exit 1; fi

git clone git@gitlab.com:iag-connect/groundside/grd-internet-viasat.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/iag/grd/grd-internet-viasat/config/_test.json-template ~/git/iag/grd/grd-internet-viasat/config/test.json || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/iag/grd/grd-internet-viasat/config/_development.json-template ~/git/iag/grd/grd-internet-viasat/config/development.json || if [ ${?} -gt 0 ]; then exit 1; fi

popd

mkdir -p ~/git/iag/libs
pushd ~/git/iag/libs

git clone git@gitlab.com:iag-connect/node-libs/node-config-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-logging-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-shared-types-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-db-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-amqp-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-dependency-injection-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-events-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/node-libs/node-http-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd

mkdir -p ~/git/iag/tools
pushd ~/git/iag/tools

git clone git@gitlab.com:iag-connect/tools/iag-process-helper.git || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/dot-air/iag-process-helper.env ~/git/iag/tools/iag-process-helper/.env || if [ ${?} -gt 0 ]; then exit 1; fi

popd

popd

if [ -f ~/.npmrc ]; then mv ~/.npmrc /tmp/; fi

stow  -v -d ~/git/setups/linux-setup-private/dotfiles/ -t ~ npm || if [ ${?} -gt 0 ]; then exit 1; fi
