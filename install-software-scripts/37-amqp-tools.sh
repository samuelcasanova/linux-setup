#!/bin/bash

echo -e '\nInstalling AMQP tools\n'

sudo apt install librabbitmq-tools || if [ ${?} -gt 0 ]; then exit 1; fi
