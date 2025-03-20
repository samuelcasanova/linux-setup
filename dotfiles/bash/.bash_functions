tests_viasat() {
    npm run test:unit
    if [ ${?} -gt 0 ]; then return; fi
    npm run clean
    if [ ${?} -gt 0 ]; then return; fi
    npm run predev
    if [ ${?} -gt 0 ]; then return; fi
    sleep 3
    DATABASE_URL="postgresql://postgres:postgres@localhost:5432/grd-internet-viasat" npm run migrate up
    npm run test:e2e
    if [ ${?} -gt 0 ]; then return; fi
    npm run test:integration
}

vpn_restart() {
    sudo ~/git/setups/linux-setup/install-software-scripts/support-files/setvpn.sh down
    sudo ~/git/setups/linux-setup/install-software-scripts/support-files/setvpn.sh up
}

vpn_start() {
    sudo ~/git/setups/linux-setup/install-software-scripts/support-files/setvpn.sh up
}

vpn_stop() {
    sudo ~/git/setups/linux-setup/install-software-scripts/support-files/setvpn.sh down
}

progress() {
    echo -ne 'Progress: #......... 10%\r\c'
    sleep 1
    echo -ne 'Progress: #####..... 50%\r\c'
    sleep 1
    echo 'Progress: ########## 100%'
}