#!/bin/bash

# Prompt user for network interface and IP address
read -p "Enter network interface name (e.g. eth0): " interface
read -p "Enter desired IP address (e.g. 192.168.0.10): " ip_address

# Set static IP address
sudo ip addr add $ip_address/24 dev $interface

# Restart networking service
sudo service networking restart

echo "Static IP address set successfully."
