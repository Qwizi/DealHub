FROM ghcr.io/coollabsio/coolify-helper:latest

# Download upgrade script

RUN curl -fsSL https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/upgrade.sh -o upgrade.sh
RUN curl -fsSL https://raw.githubusercontent.com/Qwizi/DealHub/master/scripts/install.sh -o install.sh

RUN chmod +x upgrade.sh
RUN chmod +x install.sh