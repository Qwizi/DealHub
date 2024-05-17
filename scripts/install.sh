#!/bin/bash
## Do not modify this file. You will lose the ability to install and auto-update!

set -e # Exit immediately if a command exits with a non-zero status
## $1 could be empty, so we need to disable this check
#set -u # Treat unset variables as an error and exit
set -o pipefail # Cause a pipeline to return the status of the last command that exited with a non-zero status

VERSION="0.0.2"
CDN="https://raw.githubusercontent.com/Qwizi/DealHub/master"
PROJECT_NAME="DealHub"

echo -e "Welcome to $PROJECT_NAME installer!"

# Making project directory
mkdir -p $PROJECT_NAME

echo "Downloading required files from CDN..."
curl -fsSL $CDN/docker-compose.prod.yml -o $PROJECT_NAME/docker-compose.yml
curl -fsSL $CDN/.env.example -o $PROJECT_NAME/.env.example
curl -fsSL $CDN/nginx/default.conf -o $PROJECT_NAME/default.conf
curl -fsSL $CDN/scripts/upgrade.sh -o $PROJECT_NAME/upgrade.sh

# Copy .env.example if .env does not exist
if [ ! -f $PROJECT_NAME/.env ]; then
    cp $PROJECT_NAME/.env.example $PROJECT_NAME/.env

    DJANGO_SECRET_KEY=$(openssl rand -hex 50)
    sed -i "s|SECRET_KEY=.*|SECRET_KEY=$DJANGO_SECRET_KEY|g" $PROJECT_NAME/.env

    # Update DEBUG to False
    sed -i "s|DEBUG=.*|DEBUG=False|g" $PROJECT_NAME/.env
fi

sort -u -t '=' -k 1,1 $PROJECT_NAME/.env $PROJECT_NAME/.env.example | sed '/^$/d' >$PROJECT_NAME/.env.temp && mv $PROJECT_NAME/.env.temp $PROJECT_NAME/.env

bash $PROJECT_NAME/upgrade.sh

echo -e "\nCongratulations! Your $PROJECT_NAME instance is ready to use.\n"