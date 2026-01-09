#!/bin/bash

echo -e '\nInstalling Kubectl to manage k8s\n'

pushd /tmp || if [ ${?} -gt 0 ]; then exit 1; fi

# Install kubectl
curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/$(uname | awk '{print tolower($0)}')/amd64/kubectl" || if [ ${?} -gt 0 ]; then exit 1; fi
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install kubectl plugins
curl -Ls https://plugins.cloud.int.immfly.io/install.sh | sudo sh

# Install k9s
echo -e '\nInstalling k9s now to manage k8s from the CLI\n'
read -p 'Press Enter to open the download page. You will need to copy the current version, i.e. v0.50.16. You will be prompted for this download location in the next step.'
xdg-open https://github.com/derailed/k9s/releases
read -p 'Paste the version (i.e. v0.50.16) and press ENTER: ' K9S_VERSION
wget https://github.com/derailed/k9s/releases/download/${K9S_VERSION}/k9s_linux_amd64.deb
sudo apt-get -y install ./k9s_linux_amd64.deb || if [ ${?} -gt 0 ]; then exit 1; fi
rm ./k9s_linux_amd64.deb

popd