#!/bin/bash

version="1.2"

# Download initial script
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/Ubuntu/AutoSetup.sh --output /home/ubuntu/AutoSetup.sh
chmod +x /home/ubuntu/AutoSetup.sh # add execution rights

# Run
sudo /home/ubuntu/AutoSetup.sh