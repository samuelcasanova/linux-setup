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

popd

popd


if [ -f ~/.npmrc ]; then mv ~/.npmrc /tmp/; fi

stow  -v -d ~/git/setups/linux-setup-private/dotfiles/ -t ~ npm || if [ ${?} -gt 0 ]; then exit 1; fi
