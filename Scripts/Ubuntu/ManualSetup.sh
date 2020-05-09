#!/bin/bash
local version='1.0'

if [ -z "$1" ]
    then
        printf "No argument supplied" >&2
        exit 128
fi



# REQUIREMENTS

printf "\n\n\nInstalling requirements\n=======================\n\n"
sudo apt-get install steamcmd
printf "\n\nPath export\n===========\n"
echo "export PATH=\$PATH:/usr/games" | sudo tee -a /home/steam/.bashrc



# EBS PERSISTENT STORAGE

# mount
printf "\n\nMounting persistent storage\n===========================\n\n"
printf "#sudo nvme list\n"
sudo nvme list
source /home/ubuntu/PersistentSetup.sh $1


# links
printf "\n\nCreate Link\n"
sudo -u steam ln -s /home/steam/backup/config /home/steam/config
printf "#ls -lha /home/steam\n"
ls -lha /home/steam/