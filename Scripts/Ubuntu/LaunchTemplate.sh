#!/bin/bash
local version="2.0"
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/Ubuntu/AutoSetup.sh --output /home/ubuntu/AutoSetup.sh
chmod +x /home/ubuntu/AutoSetup.sh
sudo bash /home/ubuntu/AutoSetup.sh Volume-ID
touch /home/ubuntu/.setup_complete