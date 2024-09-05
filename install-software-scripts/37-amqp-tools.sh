#!/bin/bash

echo -e '\nInstalling AMQP tools\n'

sudo apt install amqp-tools || if [ ${?} -gt 0 ]; then exit 1; fi
