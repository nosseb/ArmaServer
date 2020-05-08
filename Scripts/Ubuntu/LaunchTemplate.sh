#!/bin/bash
version="1.0"
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/Ubuntu/AutoSetup.sh --output /home/Ubuntu/AutoSetup.sh
chmod +x /home/Ubuntu/AutoSetup.sh
sudo /home/Ubuntu/AutoSetup.sh