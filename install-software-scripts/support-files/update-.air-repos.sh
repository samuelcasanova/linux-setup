#!/bin/bash

cp ~/git/iag/grd/grd-ota-data/.env ~/git/setups/linux-setup-private/dot-air/grd-ota-data.env || if [ ${?} -gt 0 ]; then exit 1; fi
cp ~/git/iag/tools/iag-process-helper/.env ~/git/setups/linux-setup-private/dot-air/iag-process-helper.env || if [ ${?} -gt 0 ]; then exit 1; fi
