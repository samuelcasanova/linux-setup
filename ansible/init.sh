#!/bin/bash
# Script to initialize a fresh Kubuntu installation
# This installs minimal dependencies (git) and Ansible

set -e

# Detect if running interactively
if [ -t 1 ]; then
    INTERACTIVE=true
else
    INTERACTIVE=false
fi

if [ "$INTERACTIVE" = true ]; then
    echo "================================================"
    echo "Initializing Kubuntu Setup"
    echo "================================================"
fi

# Update package list
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[1/3] Updating package list..."
fi
sudo apt-get update -qq

# Install Git and Ansible
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[2/3] Installing Git and Ansible..."
fi
sudo apt-get install -y -qq git ansible software-properties-common

# Verify installation
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[3/3] Verifying installation..."
fi
git --version > /dev/null
ansible --version > /dev/null

if [ "$INTERACTIVE" = true ]; then
    echo ""
    echo "================================================"
    echo "✓ System initialized successfully!"
    echo "================================================"
    echo ""
    echo "Versions:"
    git --version | head -n 1
    ansible --version | head -n 1
    echo ""
    echo "Next steps:"
    echo "  cd ~/git/setups/linux-setup/ansible"
    echo "  ansible-playbook playbooks/main.yml"
    echo ""
fi
