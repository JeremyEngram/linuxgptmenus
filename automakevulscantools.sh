#!/bin/bash

# Install Nmap and Searchsploit
sudo apt-get update
sudo apt-get install nmap exploitdb

# Install Nmap NSE scripts
sudo mkdir -p /usr/share/nmap/scripts/
cd /usr/share/nmap/scripts/
sudo git clone https://github.com/vulnersCom/nmap-vulners.git
sudo git clone https://github.com/scipag/vulscan.git

# Configure Nmap to use the new scripts
sudo cp /usr/share/nmap/nmap-services /usr/share/nmap/nmap-services.orig
sudo sh -c 'echo "vulners      5555/tcp                 # Vulners Scanning Agent" >> /usr/share/nmap/nmap-services'
sudo nmap --script-updatedb

# Configure Searchsploit to use the new scripts
sudo sed -i 's/PATHS=(\/opt\/exploit-database\/)/PATHS=(\/opt\/exploit-database\/ \/usr\/share\/nmap\/scripts\/vulscan\/)/' /usr/bin/searchsploit
sudo updatedb
