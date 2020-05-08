#!/bin/bash
version="1.1"
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/ubuntu/AutoSetup.sh --output /home/ubuntu/AutoSetup.sh
chmod +x /home/ubuntu/AutoSetup.sh
sudo /home/ubuntu/AutoSetup.sh