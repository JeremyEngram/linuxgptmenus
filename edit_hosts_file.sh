#!/bin/bash

# Prompt user for IP address and hostname
read -p "Enter IP address: " ip_address
read -p "Enter hostname: " hostname

# Add entry to /etc/hosts file
sudo sed -i "/$ip_address/d" /etc/hosts
sudo bash -c "echo \"$ip_address\t$hostname\" >> /etc/hosts"

echo "Host entry added to /etc/hosts file successfully."
