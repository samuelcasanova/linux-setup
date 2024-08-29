#!/bin/bash

echo -e '\nInstalling .air dependencies\n'

# Imagemagick v7.1 already installed in Fedora
sudo dnf install tini
sudo dnf install httpd-tools # As apache2-utils is not available, I install httpd-tools that also contains ab benchmark tool needed for air-shopping tests