#!/bin/bash
# Test script to run Ansible playbooks in Docker container
#
# Usage: ./test-playbook.sh <playbook-name> [ansible-args]
# Example: ./test-playbook.sh phase1-core-system.yml --check

set -e

PLAYBOOK=$1
shift  # Remove first argument, keep the rest for ansible

if [ -z "$PLAYBOOK" ]; then
    echo "Usage: $0 <playbook-name> [ansible-args]"
    echo "Example: $0 phase1-core-system.yml --check"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ANSIBLE_DIR="$(dirname "$SCRIPT_DIR")"
REPO_ROOT="$(dirname "$ANSIBLE_DIR")"

echo "================================================"
echo "Testing playbook: $PLAYBOOK"
echo "================================================"

# Build the test image (use ansible/ as context to access install-ansible.sh)
echo "Building test Docker image..."
docker build -t kubuntu-ansible-test -f "$SCRIPT_DIR/Dockerfile" "$ANSIBLE_DIR"

# Run the playbook in the container
echo ""
echo "Running playbook in container..."
docker run --rm \
    -v "$REPO_ROOT:/home/samuel/git/setups/linux-setup:ro" \
    -w /home/samuel/git/setups/linux-setup/ansible \
    kubuntu-ansible-test \
    ansible-playbook "playbooks/$PLAYBOOK" "$@"

echo ""
echo "================================================"
echo "Test completed successfully!"
echo "================================================"
