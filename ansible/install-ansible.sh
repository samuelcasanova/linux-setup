#!/bin/bash
# Script to install Ansible on a fresh Kubuntu installation
# This should be run BEFORE executing any Ansible playbooks
# Works both interactively and in Docker builds

set -e

# Detect if running interactively
if [ -t 1 ]; then
    INTERACTIVE=true
else
    INTERACTIVE=false
fi

if [ "$INTERACTIVE" = true ]; then
    echo "================================================"
    echo "Installing Ansible on Kubuntu"
    echo "================================================"
fi

# Update package list
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[1/3] Updating package list..."
fi
sudo apt-get update -qq

# Install Ansible
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[2/3] Installing Ansible..."
fi
sudo apt-get install -y -qq ansible

# Verify installation
if [ "$INTERACTIVE" = true ]; then
    echo -e "\n[3/3] Verifying installation..."
fi
ansible --version > /dev/null

if [ "$INTERACTIVE" = true ]; then
    echo ""
    echo "================================================"
    echo "✓ Ansible installed successfully!"
    echo "================================================"
    echo ""
    echo "Ansible version:"
    ansible --version | head -n 1
    echo ""
    echo "Next steps:"
    echo "  cd ~/git/setups/linux-setup/ansible"
    echo "  ansible-playbook playbooks/main.yml"
    echo ""
fi
