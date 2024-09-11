#!/bin/bash

echo -e '\nInstalling docker\n'
# https://docs.docker.com/engine/install/ubuntu/

for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done || if [ ${?} -gt 0 ]; then exit 1; fi

# Add Docker's official GPG key:
sudo apt-get update || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install ca-certificates curl || if [ ${?} -gt 0 ]; then exit 1; fi
sudo install -m 0755 -d /etc/apt/keyrings || if [ ${?} -gt 0 ]; then exit 1; fi
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc || if [ ${?} -gt 0 ]; then exit 1; fi
sudo chmod a+r /etc/apt/keyrings/docker.asc || if [ ${?} -gt 0 ]; then exit 1; fi

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get update || if [ ${?} -gt 0 ]; then exit 1; fi

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || if [ ${?} -gt 0 ]; then exit 1; fi

sudo systemctl start docker || if [ ${?} -gt 0 ]; then exit 1; fi

echo -e '\nConfiguring docker for non-root user samuel (2/2)\n'

# https://docs.docker.com/engine/install/linux-postinstall/
if [ ! $(getent group docker) ]; then sudo groupadd docker; fi || if [ ${?} -gt 0 ]; then exit 1; fi
sudo usermod -aG docker $USER || if [ ${?} -gt 0 ]; then exit 1; fi
newgrp docker || if [ ${?} -gt 0 ]; then exit 1; fi

sudo systemctl enable docker.service || if [ ${?} -gt 0 ]; then exit 1; fi
sudo systemctl enable containerd.service || if [ ${?} -gt 0 ]; then exit 1; fi
