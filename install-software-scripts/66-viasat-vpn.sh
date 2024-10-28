#!/bin/bash

echo -e '\nInstalling Cisco Any Connect\n'

read -p 'Place the anyconnect-linux64-4.10.X-predeploy-k9.tar.gz file in some local directory and copy the location. You will be prompted in a further step for the location.'
read -p 'Paste the local file location and press ENTER: ' REALVNC_INSTALLER_PATH

if [[ ! -d /tmp/anyconnect ]]
then
    mkdir -p /tmp/anyconnect
fi

pushd /tmp/anyconnect

rm -rf *
tar xvf ${REALVNC_INSTALLER_PATH}
cd $(ls -d */)
cd vpn
rm license.txt
sudo ./vpn_install.sh

popd