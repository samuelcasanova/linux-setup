#!/bin/bash

echo -e '\nInstalling .air groundside and rest of repositories\n'

mkdir -p ~/git/iag/grd
pushd ~/git/iag/grd

git clone git@gitlab.com:iag-connect/groundside/grd-entitlements-v2.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/grd-flight-data.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/grd-ota-data.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/grd-internet-viasat.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd


mkdir -p ~/git/iag/libs
pushd ~/git/iag/libs

git clone git@gitlab.com:iag-connect/groundside/node-config-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/node-logging-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi
git clone git@gitlab.com:iag-connect/groundside/node-shared-types-lib.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd

mkdir -p ~/git/iag/tools
pushd ~/git/iag/tools

git clone git@gitlab.com:iag-connect/tools/iag-process-helper.git || if [ ${?} -gt 0 ]; then exit 1; fi

popd

echo -e '\nCopying .env files\n'

#grd-entitlements-v2 TBD
#grd-flight-data TBD
#grd-internet-viasat TBD
cp ~/git/setups/linux-setup-private/dot-air/grd-ota-data.env ~/git/iag/grd/grd-ota-data/.env || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/setups/linux-setup-private/dot-air/iag-process-helper.env ~/git/iag/tools/iag-process-helper/.env || if [ ${?} -gt 0 ]; then exit 1; fi