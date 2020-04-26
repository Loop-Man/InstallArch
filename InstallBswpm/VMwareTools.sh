#!/bin/bash

echo "Introducir disco de las vmware tools"
echo "Seleccionar en vmware VM --> Install VMware Tools Installation"
echo "Pulsar cualquier tecla para continuar una vez realizado esto"
read 
sudo pacman -Syu
sudo pacman -S --noconfirm --needed net-tools linux-headers xf86-input-vmmouse xf86-video-vmware
sudo mkdir -p /etc/init.d/{rc0.d,rc1.d,rc2.d,rc3.d,rc4.d,rc5.d,rc6.d}
sduo mkdir -p /mnt/cdrom
sudo mount /dev/cdrom /mnt/cdrom
sleep 5
tar xf /mnt/cdrom/VMwareTools*.tar.gz -C ~/
sudo perl ~/vmware-tools-distrib/vmware-install.pl
sudo umount /dev/cdrom

##Creamos el servicio y lo activamos para que se ejecute al inicio

sudo cp ./vmwaretools.service /etc/systemd/system/
sudo systemctl enable vmwaretools.service

echo "Finish"
