#!/bin/bash

# Enable USB OTG
echo "dtoverlay=dwc2" | sudo tee -a /boot/config.txt
echo "dwc2" | sudo tee -a /etc/modules

# Load kernel modules
sudo modprobe libcomposite
sudo modprobe usb_f_mass_storage

# Set up USB gadget
sudo mkdir -p /piusb
sudo chmod 777 /piusb
cd /sys/kernel/config/usb_gadget/
sudo mkdir -p pihub/functions/mass_storage.usb0
sudo echo 1 > pihub/functions/mass_storage.usb0/stall
sudo echo 0 > pihub/functions/mass_storage.usb0/lun.0/cdrom
sudo echo 0 > pihub/functions/mass_storage.usb0/lun.0/ro
sudo echo "/dev/sda1" > pihub/functions/mass_storage.usb0/lun.0/file
sudo mkdir -p pihub/configs/c.1/strings/0x409
sudo echo "Pi USB" > pihub/configs/c.1/strings/0x409/configuration
sudo echo 250 > pihub/configs/c.1/MaxPower
sudo ln -s pihub/configs/c.1 pihub/os_desc
sudo echo "0x1d6b" > pihub/idVendor
sudo echo "0x0104" > pihub/idProduct
sudo echo "0102030405060708" > pihub/strings/0x409/serialnumber
sudo echo "Pi USB" > pihub/strings/0x409/manufacturer
sudo echo "Pi USB Mass Storage" > pihub/strings/0x409/product

# Run script on device connect
sudo mkdir -p /etc/udev/rules.d/
echo 'SUBSYSTEM=="usb", ATTRS{idVendor}=="1d6b", ATTRS{idProduct}=="0104", RUN+="/usr/bin/mount /piusb"' | sudo tee /etc/udev/rules.d/99-mass-storage.rules

# Restart udev service
sudo service udev restart
