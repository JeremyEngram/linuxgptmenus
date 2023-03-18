#!/bin/bash

# Update package lists
sudo apt-get update

# Install tools
sudo apt-get install -y nmap nikto sqlmap metasploit-framework hydra aircrack-ng tcpdump john hashcat burpsuite

# Add Kali Linux repositories
sudo sh -c 'echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" > /etc/apt/sources.list.d/kali.list'
wget -q -O - https://archive.kali.org/archive-key.asc | sudo apt-key add -
sudo apt-get update

# Install Kali Linux tools
sudo apt-get install -y kali-linux-top10

# Generate man pages for installed tools
sudo mkdir /usr/local/man/man1/
for cmd in $(ls /usr/bin); do
    man -t $cmd | ps2pdf - - > /usr/local/man/man1/$cmd.1.pdf
done
