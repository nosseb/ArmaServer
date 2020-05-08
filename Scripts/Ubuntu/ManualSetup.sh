#!/bin/bash
version='0.2'

# REQUIREMENTS
sudo apt-get install steamcmd
export PATH=/usr/games:$PATH


# EBS PERSISTENT STORAGE

# mount
ebsArma=$(sudo nvme list | grep VolumeID | cut -d " " -f1) # path to ebs storage
sudo mount $ebsArma /home/steam/backup # mount
sudo chown steam:steam /home/steam/backup # change owner

# links
sudo -u steam ln -s /home/steam/backup/config /home/steam/config