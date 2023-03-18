#!/bin/bash

# Get network subnet
read -p "Enter network subnet (e.g. 192.168.0.0/24): " subnet

# Show list of live hosts
echo "Live hosts on network:"
nmap -sP $subnet | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}' 

# Perform Nmap scan on live hosts
echo "Scanning live hosts for available services:"
nmap -p 1-65535 $(nmap -sP $subnet | awk '/^Nmap/{ip=$NF}/B8:27:EB/{print ip}') -oN nmap_scan.txt

echo "Nmap scan completed successfully. Results saved to nmap_scan.txt."
