#!/bin/bash

############################################################
# Bash script to install Docker CE stable on Ubuntu
# Source: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-docker-ce-1
# Author: Joshua Haupt josh@hauptj.com Date: 5.1.2018
############################################################

set -e
# Any subsequent(*) commands which fail will cause the shell script to exit immediately


# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io

##### Set up the repository #####

# Update the apt package index
sudo apt-get update


# Install packages to allow apt to use a repository over HTTPS
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
	
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

## TODO auto verification ##
echo "Verify that you now have the key with the fingerprint 9DC8 5822 9FC7 DD38 854A E2D8 8D81 803C 0EBF CD88, by searching for the last 8 characters of the fingerprint."
echo "Y/N?"
read userInput

# Abort on N continue if Y
# ERROR: ./UbuntuDockerInstall.sh: line 38: [Y: command not found
if ["$userInput" != "Y"]
then
	exit
fi

# Set up the stable repository
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   

##### Install Docker CE #####

# Update the apt package index
sudo apt-get update

# Install the latest version of Docker CE, or go to the next step to install a specific version. Any existing installation of Docker is replaced.
sudo apt-get install docker-ce