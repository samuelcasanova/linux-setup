#!/bin/bash

echo -e '\nInstalling Kubectl to manage k8s\n'

pushd /tmp || if [ ${?} -gt 0 ]; then exit 1; fi

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$(uname | awk '{print tolower($0)}')/amd64/kubectl" || if [ ${?} -gt 0 ]; then exit 1; fi
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install kubectl plugins
curl -Ls https://plugins.cloud.int.immfly.io/install.sh | sudo sh

popd