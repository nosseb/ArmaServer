#!/bin/bash

version="0.6"

#TODO: look for blockdevice ID in parameters

# ENABLE LOGGING

exec 3>&1 4>&2 # Saves file descriptors
trap 'exec 2>&4 1>&3' 0 1 2 3 RETURN # Restore file descriptors.
# The RETURN pseudo sigspec restore file descriptors each time a shell function or a script executed with the . or source builtins finishes executing.
exec 1>/home/ubuntu/log.out 2>&1

printf "AutoSetup.sh version $version\n"


# REQUIREMENTS
printf "\n\n\n\nInstalling requirements\n=======================\n\n"
sudo add-apt-repository -y ppa:sbates # Repository for nvme-cli
sudo add-apt-repository -y multiverse # Repository for SteamCMD
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install nvme-cli # for scripting purposes
sudo apt-get install zip dos2unix git #misc
sudo apt-get -y install lib32gcc1 # SteamCMD requirement


# USER CREATION
printf "\n\n\n\nAdding user\n===========\n"
sudo useradd -m -s /bin/bash steam
sudo -u steam mkdir /home/steam/local
sudo -u steam mkdir /home/steam/backup
printf "\n#ls -lha /home/steam\n"
ls -lha /home/steam


# LOCAL INSTACE STORAGE
printf "\n\n\n\nMounting local storage\n======================\n\n"
printf "#sudo nvme list\n"
sudo nvme list
printf "\n\n"
InstanceDevice=$(sudo nvme list | grep Instance | cut -d " " -f1) # path to local storage device
End="p1"
InstancePart=$InstanceDevice$End # path to local storage partition
printf "\n\nInstance partition: $InstancePart\n\n"

# create partition
sudo sfdisk $InstanceDevice << EOF
;
EOF

sudo mkfs.ext4 $InstancePart # format partition

# mount
sudo mount $InstancePart /home/steam/local # mount partition
printf "\n\n#lsblk\n"
lsblk
sudo chown -R steam:steam /home/steam/local # change owner
printf "#ls -lha /home/steam\n"
ls -lha /home/steam/
printf "\n\n"

function make_steam_folder () {
    if [ ! -d /home/steam/local/$1 ]
    then
        sudo -u steam mkdir /home/steam/local/$1
    fi
    sudo -u steam ln -s /home/steam/local/$1 /home/steam/$1
}

make_steam_folder .steam
make_steam_folder Steam
make_steam_folder arma3

printf "\n\n#ls -lha /home/steam/\n"
ls -lha /home/steam/
printf "\n\n#ls -lha /home/steam/local/\n"
ls -lha /home/steam/local/


# DOWNLOAD ADDITIONAL SCRIPTS
printf "\n\n\n\nDownloading additional files\n============================\n\n"
curl https://raw.githubusercontent.com/nosseb/ArmaServer/master/Scripts/Ubuntu/ManualSetup.sh --output /home/ubuntu/ManualSetup.sh
chmod +x /home/ubuntu/ManualSetup.sh
printf "#ls -lha /home/ubuntu\n"
ls -lha /home/ubuntu/

# Download user scripts
printf "\n Download user scripts\n"
function download_script () {
    sudo -u steam curl https://github.com/nosseb/ArmaServer/blob/master/Scripts/steam/$1 --output /home/steam/$1
    sudo -u steam chmod +x /home/steam/$1
}

download_script backup_steam.sh
download_script restore_steam.sh
download_script start_arma.sh
download_script stop_arma.sh
download_script update_arma.sh
download_script update_config.sh

printf "#ls -lha /home/steam\n"
ls -lha /home/steam/

#TODO: check if blockdevice avalible
#TODO: If block device availble, mount it


# QUIT AND DESABLE LOGGING

exit 0