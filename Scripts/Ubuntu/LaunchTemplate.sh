#!/bin/bash
version="1.2"
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/Ubuntu/AutoSetup.sh --output /home/ubuntu/AutoSetup.sh
chmod +x /home/ubuntu/AutoSetup.sh
sudo /home/ubuntu/AutoSetup.sh