#!/bin/bash
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo usermod -aG docker ${USER}

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Generate SSH key pair
ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa

# Enable public key login in sshd_config
sudo sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config


# Append generated public key to authorized_keys
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 700 ~/.ssh/authorized_keys

# Restart SSH server
sudo service ssh restart

# Display contents of id_rsa private key
echo "SSH key pair generated and configured for public key authentication."
echo "Contents of id_rsa private key:"
cat ~/.ssh/id_rsa
