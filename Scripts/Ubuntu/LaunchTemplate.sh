#!/bin/bash

version="1.4"

# Download initial script
# TODO: correct url
curl https://raw.githubusercontent.com/nosseb/ArmaServer/Ubik/Scripts/Ubuntu/AutoSetup.sh --output /home/ubuntu/AutoSetup.sh
chmod +x /home/ubuntu/AutoSetup.sh # add execution rights

# Run
sudo bash /home/ubuntu/AutoSetup.sh

touch /home/ubuntu/.setup_complete