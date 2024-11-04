#!/bin/bash

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to check if WireGuard interface is running
    is_wg_interface_running() {
    sudo wg show "$1" >/dev/null 2>&1
}

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    echo "Please enter your password:"
    read -s password
    echo $password | sudo -S bash "$0" "$@"
    exit
fi

# Check if nslookup is installed
if ! command_exists nslookup; then
    echo "nslookup command not found. Please install it and try again."
    exit 1
fi

# Check if WireGuard is installed
if ! command_exists wg; then
    echo "WireGuard is not installed. Please install it and try again."
    exit 1
fi

# Check if the WireGuard configuration file exists
[[ $OSTYPE == 'darwin'* ]] && WG_CONF_FILE="/usr/local/etc/wireguard/wg1.conf" || WG_CONF_FILE="/etc/wireguard/wg1.conf"

if [ ! -f "$WG_CONF_FILE" ]; then
    echo "ERROR: WireGuard configuration file ($WG_CONF_FILE) not found. Exiting..."
    exit 1
fi

# Check the number of arguments
if [ $# -ne 1 ]; then
    echo "Usage: $0 [up|down]"
    exit 1
fi

# Store the positional argument in a variable
direction=$1

# Perform actions based on the argument
if [ "$direction" = "up" ]; then
    echo "Performing actions for 'up'..."

    # Execute the nslookup command and process the output
    result=$(echo 192.168.150.0/24, 192.168.190.0/24, $(nslookup tooling-alb-tf-1316935705.eu-west-1.elb.amazonaws.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup dot-air.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup api.dot-air.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup dev.iag-bsa.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup development-kibana.iag-bsa.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup production-eks-kibana.iag-bsd.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-), $(nslookup com-mob-b2b.us.canary.viasat.com | grep "Address" | tail -n +2 | awk '{printf $0 "/32"}' | sed 's/Address:/,/g' | sed 's/#[0-9][0-9]//g' | cut -c3-))

    # Replace the "AllowedIPs" field in the WireGuard configuration file
    awk -v ips="$result" '/AllowedIPs/{$0="AllowedIPs = "ips}1' "$WG_CONF_FILE" > temp && mv temp "$WG_CONF_FILE"

    # Check if WireGuard interface is already running
    if is_wg_interface_running "wg1"; then
        # WireGuard interface is already running, restart it
        echo "WireGuard interface is already running, restarting..."
        sudo wg-quick down wg1
        sudo wg-quick up wg1
    else
        # WireGuard interface is not running, bring it up
        echo "WireGuard interface is not running, bringing it up..."
        sudo wg-quick up wg1
    fi

elif [ "$direction" = "down" ]; then
    echo "Performing actions for 'down'..."

    # WireGuard down
    sudo wg-quick down wg1

else
    echo "Invalid argument: $direction"
    exit 1
fi
