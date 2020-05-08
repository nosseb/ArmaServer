#!/bin/bash
version="0.2"


# ENABLE LOGGING

exec 3>&1 4>&2 # Saves file descriptors
trap 'exec 2>&4 1>&3' 0 1 2 3 RETURN # Restore file descriptors.
# The RETURN pseudo sigspec restore file descriptors each time a shell function or a script executed with the . or source builtins finishes executing.
exec 1>log.out 2>&1

echo "AutoSetup.sh version" $version


# REQUIREMENTS

sudo add-apt-repository -y ppa:sbates # Repository for nvme-cli
sudo add-apt-repository -y multiverse # Repository for SteamCMD
sudo dpkg --add-architecture i386
sudo apt-get update
sudo apt-get install nvme-cli # for scripting purposes
sudo apt-get -y install lib32gcc1 # SteamCMD requirement


# USER CREATION

sudo useradd -m -s /bin/bash steam
sudo -u steam mkdir /home/steam/local
sudo -u steam mkdir /home/steam/backup


# LOCAL INSTACE STORAGE

InstanceDevice=$(sudo nvme list | grep Instance | cut -d " " -f1) # path to local storage device
End="p1"
InstancePart=$InstanceDevice$End # path to local storage partition

# create partition
sudo sfdisk $InstanceDevice << EOF
;
EOF

sudo mkfs.ext4 $InstancePart # format partition

# mount
sudo mount $InstancePart /home/steam/local # mount partition
sudo chown -R steam:steam /home/steam/local # change owner

# creating .steam folder
# not needed on reboot
if [ ! -d /home/steam/local/.steam ]
then
    sudo -u steam mkdir /home/steam/local/.steam
fi
sudo -u steam ln -s /home/steam/local/.steam /home/steam/.steam

# creating Steam folder
# not needed on reboot
if [ ! -d /home/steam/local/Steam ]
then
    sudo -u steam mkdir /home/steam/local/Steam
fi
sudo -u steam ln -s /home/steam/local/Steam /home/steam/Steam


# DOWNLOAD ADDITIONAL SCRIPTS

curl https://LinkToManualSetup.sh --output ManualSetup.sh
chmod +x ManualSetup.sh


# QUIT AND DESABLE LOGGING

return
exit 0