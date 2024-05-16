#!/bin/bash
## Do not modify this file. You will lose the ability to install and auto-update!

set -e # Exit immediately if a command exits with a non-zero status
## $1 could be empty, so we need to disable this check
#set -u # Treat unset variables as an error and exit
set -o pipefail # Cause a pipeline to return the status of the last command that exited with a non-zero status

VERSION="0.0.1"
CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"
OS_TYPE=$(grep -w "ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')

# Check if the OS is manjaro, if so, change it to arch
if [ "$OS_TYPE" = "manjaro" ]; then
    OS_TYPE="arch"
fi

if [ "$OS_TYPE" = "arch" ]; then
    OS_VERSION="rolling"
else
    OS_VERSION=$(grep -w "VERSION_ID" /etc/os-release | cut -d "=" -f 2 | tr -d '"')
fi

# Install xargs on Amazon Linux 2023 - lol
if [ "$OS_TYPE" = 'amzn' ]; then
    dnf install -y findutils >/dev/null 2>&1
fi

echo -e "-------------"
echo -e "Welcome to DealHub installer!"
echo -e "This script will install everything for you."
echo -e "-------------"

echo "OS: $OS_TYPE $OS_VERSION"

echo -e "Creating directories..."

mkdir -p DealHub/

echo "Downloading required files from CDN..."
curl -fsSL $CDN/docker-compose.prod.yml -o DealHub/docker-compose.yml
curl -fsSL $CDN/.env.example -o DealHub/.env.example
curl -fsSL $CDN/nginx/default.conf -o DealHub/default.conf
curl -fsSL $CDN/scripts/upgrade.sh -o DealHub/upgrade.sh

chmod +x DealHub/upgrade.sh

# Copy .env.example if .env does not exist
if [ ! -f DealHub/.env ]; then
    cp DealHub/.env.example DealHub/.env

    DJANGO_SECRET_KEY=$(openssl rand -hex 50)
    sed -i "s|SECRET_KEY=.*|SECRET_KEY=$DJANGO_SECRET_KEY|g" DealHub/.env

    # Update DEBUG to False
    sed -i "s|DEBUG=.*|DEBUG=False|g" DealHub/.env
fi

sort -u -t '=' -k 1,1 DealHub/.env DealHub/.env.example | sed '/^$/d' >DealHub/.env.temp && mv DealHub/.env.temp DealHub/.env

echo -e "\nCongratulations! Your DealHub instance is ready to use.\n"
