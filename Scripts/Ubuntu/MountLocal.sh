#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0


# Load path to local storage
InstanceDevice=$(sudo nvme list | grep Instance | cut -d" " -f1) # path to local storage device
End="p1"
InstancePart=$InstanceDevice$End # path to local storage partition
if [ -z "$InstanceDevice" ]
then
    printf "\nDid not find instance storage\n" 1>&2
    exit 1
fi

# create partition
sudo sfdisk "$InstanceDevice" << EOF
;
EOF

sleep 5s

sudo mkfs.ext4 "$InstancePart" # format partition

# mount
sudo mount "$InstancePart" /home/steam/local # mount partition
printf "\n\n#lsblk\n"
lsblk
sudo chown -R steam:steam /home/steam/local # change owner
printf "#ls -lha /home/steam\n"
ls -lha /home/steam/
printf "\n\n"

function make_steam_folder () {
    if [ ! -d /home/steam/local/"$1" ]
    then
        sudo -u steam mkdir /home/steam/local/"$1"
    fi
    sudo -u steam ln -s /home/steam/local/"$1" /home/steam/"$1"
}

make_steam_folder .steam
make_steam_folder Steam
make_steam_folder arma3

printf "\n\n#ls -lha /home/steam/\n"
ls -lha /home/steam/
printf "\n\n#ls -lha /home/steam/local/\n"
ls -lha /home/steam/local/
