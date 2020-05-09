#!/bin/bash
version='0.1'

if [ -z "$1" ]
    then
        printf "No argument supplied" >&2
        exit 128
fi

if [[ $1 == "vol-"* ]]
    then
        ebs=${1//vol-/}
    else
        ebs=$1
fi

ebsArma=$(sudo nvme list | grep $ebs | cut -d" " -f1 | cut -d"/" -f3) # path to ebs storage
printf "\n\n#ebsArma : $ebsArma\n\n"
if [ $ebsArma ]
    then
        printf "\n\nPersistent storage detected\n\n"
        mounted=$(lsblk | grep $ebsArma | tr -s ' ' | cut -d" " -f7) # path of mounted dirrectory
        if [ $mounted ]
            then
                printf "\n\nPersistent storage already mounted.\n\n"
            else
                printf "\n\nPersistent storage not mounted.\n\n"
                printf "mount\n"
                sudo mount /dev/$ebsArma /home/steam/backup # mount
                printf "\n\n#lsblk\n"
                lsblk
                printf "\nChange owner\n"
                sudo chown steam:steam /home/steam/backup # change owner
        fi
    else
        printf "\n\nPersistent storage not detected\n\n"
fi