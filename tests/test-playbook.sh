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
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
PRIVATE_REPO="$(dirname "$REPO_ROOT")/linux-setup-private"

echo "================================================"
echo "Testing playbook: $PLAYBOOK"
echo "================================================"

# Build the test image (use the repo root as context to access init.sh)
echo "Building test Docker image..."
rsync -a "$PRIVATE_REPO" "$SCRIPT_DIR/files/"
docker build -t kubuntu-ansible-test -f "$SCRIPT_DIR/Dockerfile" "$REPO_ROOT"
rm -rf "$SCRIPT_DIR/files/linux-setup-private"

# Run the playbook in the container
echo ""
echo "Running playbook in container..."
docker run --rm \
    -v "$REPO_ROOT:/home/samuel/git/setups/linux-setup:ro" \
    -w /home/samuel/git/setups/linux-setup \
    kubuntu-ansible-test \
    ansible-playbook "playbooks/$PLAYBOOK" "$@"

echo ""
echo "================================================"
echo "Test completed successfully!"
echo "================================================"
