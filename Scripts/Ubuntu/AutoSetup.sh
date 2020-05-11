#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0

#TODO: look for blockdevice ID in parameters

# ENABLE LOGGING

exec 3>&1 4>&2 # Saves file descriptors
trap 'exec 2>&4 1>&3' 0 1 2 3 RETURN # Restore file descriptors.
# The RETURN pseudo sigspec restore file descriptors each time a shell function or a script executed with the . or source builtins finishes executing.
exec 1>/home/ubuntu/log.out 2>&1

printf "AutoSetup.sh version %s\n" $version


# REQUIREMENTS
printf "\n\n\n\nInstalling requirements\n=======================\n\n"
sudo apt-get update > /dev/null
sudo apt-get -y install nvme-cli > /dev/null # for scripting purposes
sudo apt-get -y install zip dos2unix git > /dev/null #misc
sudo apt-get -y install lib32gcc1 > /dev/null # SteamCMD requirement


# USER CREATION
printf "\n\n\n\nAdding user\n===========\n"
sudo useradd -m -s /bin/bash steam
sudo -u steam mkdir /home/steam/loca
sudo -u steam mkdir /home/steam/backup
printf "\n#ls -lha /home/steam\n"
ls -lha /home/steam

# DOWNLOAD SETUP SCRIPTS
printf "\n\n\n\nDownloading additional files\n============================\n\n"
function download_admin_script () {
    #TODO: change dev url
    curl https://raw.githubusercontent.com/nosseb/Ehwaz/Ubik/Scripts/Ubuntu/"$1" --output /home/ubuntu/"$1"
    chmod +x /home/ubuntu/"$1"
}

download_admin_script ManualSetup.sh > /dev/null
download_admin_script MountPersistent.sh > /dev/null
download_admin_script MountLocal.sh > /dev/null
printf "#ls -lha /home/ubuntu\n"
ls -lha /home/ubuntu/

# MOUNT LOCAL STORAGE
# shellcheck disable=SC1091
source /home/ubuntu/MountLocal.sh

# DOWNLOAD USER SCRIPTS
printf "\n Download user scripts\n"
function download_user_script () {
    #TODO: change dev url
    sudo -u steam curl https://raw.githubusercontent.com/nosseb/Ehwaz/Ubik/Scripts/steam/"$1" --output /home/steam/"$1"
    sudo -u steam chmod +x /home/steam/"$1"
}

download_user_script backup_steam.sh > /dev/null
download_user_script restore_steam.sh > /dev/null
download_user_script start_arma.sh > /dev/null
download_user_script stop_arma.sh > /dev/null
download_user_script update_arma.sh > /dev/null
download_user_script update_config.sh > /dev/null
printf "#ls -lha /home/steam\n"
ls -lha /home/steam/

# GET PASSWORDS
cp /home/ubuntu/password.txt /home/steam/password.txt 
sudo chown steam:steam /home/steam/password.txt 

# MOUNT PERSISTENT STORAGE
# shellcheck disable=SC1091
source /home/ubuntu/MountPersistent.sh "$1"


# QUIT AND DESABLE LOGGING
exit 0