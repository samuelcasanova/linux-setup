#!/bin/bash

echo -e '\nInstalling AMQP tools\n'

sudo apt-get -y install amqp-tools || if [ ${?} -gt 0 ]; then exit 1; fi
