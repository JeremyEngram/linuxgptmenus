#!/bin/bash

# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check if Metasploit is installed
if ! command -v msfconsole &> /dev/null
then
    echo "Metasploit is not installed"
    exit 1
fi

# Stop Metasploit
msfconsole -q -x 'exit'

# Remove Metasploit
rm -rf /usr/share/metasploit-framework
rm -rf /opt/metasploit-framework
rm -rf /root/.msf4

# Uninstall Metasploit packages
if [[ -f /etc/debian_version ]]; then
    apt-get -y remove metasploit-framework
    apt-get -y remove ruby
    apt-get -y autoremove
elif [[ -f /etc/redhat-release ]]; then
    yum -y remove metasploit-framework
    yum -y remove ruby
    yum -y autoremove
else
    echo "Unsupported Linux distribution"
    exit 1
fi

echo "Metasploit has been removed"
