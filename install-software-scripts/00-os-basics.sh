#!/bin/bash

echo -e '\nInstalling basic OS software\n'

#GRUB2 Default boot
echo -e 'Changing to default start with MS Windows'
if [[ ! -d /tmp/grub.d ]]; then mkdir /tmp/grub.d; fi
sudo cp -rp /etc/grub.d/* /tmp/grub.d || if [ ${?} -gt 0 ]; then exit 1; fi
if [[ ! -d /etc/grub.d/30_os-prober ]]; then sudo mv /etc/grub.d/30_os-prober /etc/grub.d/09_os-prober; fi || if [ ${?} -gt 0 ]; then exit 1; fi
#sudo sed -i 's/UPDATEDEFAULT=yes/UPDATEDEFAULT=no/g' /etc/sysconfig/kernel || if [ ${?} -gt 0 ]; then exit 1; fi, NOT PRESENT IN DEBIAN BASED SYSTEMS
sudo grub-mkconfig -o /boot/grub/grub.cfg || if [ ${?} -gt 0 ]; then exit 1; fi

#GRUB2 Theme
#https://k1ng.dev/distro-grub-themes/installation#manual-installation
# echo -e 'Installing GRUB2 theme\n'
# sudo mkdir /boot/grub2/themes
# sudo mkdir /boot/grub2/themes/fedora
# wget -O /tmp/fedora.tar https://github.com/AdisonCavani/distro-grub-themes/raw/master/themes/fedora.tar
# sudo tar -C /boot/grub2/themes/fedora -xf /tmp/fedora.tar
# sudo cp /etc/default/grub /tmp/grub.bak 
# if sudo grep -q GRUB_GFXMODE /etc/default/grub; then
#     sudo sed -i 's/GRUB_GFXMODE=[0-9]\+x[0-9]\+/GRUB_GFXMODE=1280x800/' /etc/default/grub
# else
#     echo 'GRUB_GFXMODE=1280x800' | sudo tee -a /etc/default/grub
# fi
# sudo sed -i 's/GRUB_TERMINAL_OUTPUT/#GRUB_TERMINAL_OUTPUT/' /etc/default/grub
# echo 'GRUB_THEME="/boot/grub2/themes/fedora/theme.txt"' | sudo tee -a /etc/default/grub
# sudo grub2-mkconfig -o /boot/grub2/grub.cfg

#Stow
sudo apt-get -y install stow || if [ ${?} -gt 0 ]; then exit 1; fi

#Networking tools
sudo apt-get -y install inetutils-traceroute || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install net-tools || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install nmap || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install curl || if [ ${?} -gt 0 ]; then exit 1; fi
sudo apt-get -y install tree || if [ ${?} -gt 0 ]; then exit 1; fi