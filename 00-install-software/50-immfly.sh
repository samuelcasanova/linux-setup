#!/bin/bash

echo 'Installing Immfly mandatory software to work'

INSTALLER_COMMAND='sudo dnf install'

${INSTALLER_COMMAND} wireguard-tools
