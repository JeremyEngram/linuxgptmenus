
# Check if the script is being run with root privileges
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# Check the Linux distribution
distro=$(awk -F= '/^NAME/{print $2}' /etc/os-release)
if [[ $distro == *"Ubuntu"* ]]; then
    # Update and upgrade packages
    apt update && apt upgrade -y

    # Install required packages
    apt install -y curl gnupg2 git

    # Install Metasploit
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall

elif [[ $distro == *"Debian"* ]]; then
    # Update and upgrade packages
    apt update && apt upgrade -y

    # Install required packages
    apt install -y curl gnupg2 git

    # Install Metasploit
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall

elif [[ $distro == *"CentOS"* ]]; then
    # Update and upgrade packages
    yum update -y

    # Install required packages
    yum install -y curl gnupg2 git

    # Install Metasploit
    curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
    chmod 755 msfinstall && \
    ./msfinstall

else
    echo "Unsupported Linux distribution"
    exit 1
fi

# Configure Metasploit
msfdb init

# Start Metasploit
msfconsole
