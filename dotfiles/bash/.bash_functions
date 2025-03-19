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
