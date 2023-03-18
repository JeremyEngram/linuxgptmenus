#!/bin/bash

# Prompt the user to enter the base directory for SSH keys
read -p "Enter the base directory for SSH keys (default: $HOME/.ssh): " SSH_KEY_DIR
SSH_KEY_DIR=${SSH_KEY_DIR:-"$HOME/.ssh"}

# Prompt the user to enter the list of hostnames and IP addresses to connect to
read -p "Enter the list of hostnames and IP addresses to connect to, separated by spaces: " -a HOSTS

# Prompt the user to enter the username to use for SSH connections
read -p "Enter the username to use for SSH connections: " USERNAME

# Prompt the user to enter the port to use for SSH connections
read -p "Enter the port to use for SSH connections (default: 22): " PORT
PORT=${PORT:-22}

# Prompt the user to enter the path to the SSH key to use for authentication
read -p "Enter the path to the SSH key to use for authentication (default: $SSH_KEY_DIR/id_rsa): " SSH_KEY
SSH_KEY=${SSH_KEY:-"$SSH_KEY_DIR/id_rsa"}

# Create the SSH key directory if it does not already exist
if [ ! -d "$SSH_KEY_DIR" ]; then
  mkdir "$SSH_KEY_DIR"
  chmod 700 "$SSH_KEY_DIR"
fi

# Generate a new SSH key if one does not already exist
if [ ! -f "$SSH_KEY" ]; then
  ssh-keygen -t rsa -b 4096 -C "$USERNAME@$(hostname)" -f "$SSH_KEY"
  chmod 600 "$SSH_KEY"
fi

# Create the sshd_config file
cat << EOF > /etc/ssh/sshd_config
# Allow connections based on hostname only
UseDNS no
# Allow password authentication
PasswordAuthentication yes
# Use the SSH key for authentication
AuthorizedKeysFile $SSH_KEY_DIR/id_rsa.pub
# Disable root login
PermitRootLogin no
# Allow connections from any IP address
ListenAddress 0.0.0.0
# Allow connections on the specified port
Port $PORT
EOF

# Restart the SSH service
sudo service ssh restart

# Add the SSH key to the authorized_keys file on each host
for host in "${HOSTS[@]}"; do
  ssh-copy-id -i "$SSH_KEY.pub" "$USERNAME@$host"
done
