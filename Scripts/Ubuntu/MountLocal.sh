#!/bin/bash
# Provided under MIT Licence
# https://github.com/nosseb/Ehwaz
version=2.0




# TEST IF STORAGE EXIST
PathToInstanceStorage=$(sudo nvme list | grep Instance | cut -d" " -f1)
printf "Detected Instance Storage :  "
if [ ! "$PathToInstanceStorage" ]
then
	printf "FAIL\n"
	#TODO: wait and retry
	printf "E: Failed to detect Instance Storage" 1>&2
	exit 1
else
	printf "OK\n"
fi


# TEST IF PARTITION EXIST
PathToInstancePartition="$PathToInstanceStorage""p1"
function update_InstancePartitionExists () {
	InstancePartitionExists=$(ls /dev/"$PathToInstancePartition")
}
printf "Instance partition exist :  "
update_InstancePartitionExists
if [ ! "$InstancePartitionExists" ]
then
	printf "FAIL\n"
	function create_partition () {
	sudo sfdisk "$PathToInstanceStorage" <<- EOF
	;
	EOF
	}
	create_partition > /dev/null
else
	printf "OK\n"
fi


# TEST IF PARTITION FORMATED
function update_InstancePartitionFormat () {
	InstancePartitionFormat=$(df -Th | grep "$PathToInstanceStorage" | tr -s ' ' | cut -d" " -f2)
}
printf "Instance partition formated :  "
update_InstancePartitionFormat
if [ "$InstancePartitionFormat" != "ext4" ]
then
	printf "FAIL\n"
	sudo mkfs.ext4 "$PathToInstancePartition" > /dev/null
else
	printf "OK\n"
fi


# TEST IF PARTITION MOUNTED
InstancePartitionName=$("$PathToInstanceStorage" | cut -d"/" -f3)
function update_InstancePartitionMountPoint () {
	InstancePartitionMountPoint=$(lsblk | grep "$InstancePartitionName" | tr -s ' ' | cut -d" " -f7)
}
printf "Instance partition mounted :  "
update_InstancePartitionMountPoint
if [ ! "$InstancePartitionMountPoint" ]
then
	printf "FAIL\n"
	mount "$PathToInstancePartition" /home/steam/local
elif [ "$InstancePartitionMountPoint" != "/home/steam/local" ]
then
	printf "FAIL\n"
	#TODO: umount and mount partition
else
	printf "OK\n"
fi


# TEST OWNER OF MOUNT DIRECTORY
function update_MountPointOwner () {
	MountPointOwner=$(stat -c '%U:%G' /home/steam/local)
}
update_MountPointOwner
printf "Owner of instance partition mount point is valid :  "
if [ "$MountPointOwner" != "steam:steam" ]
then
	printf "FAIL\n"
	chown -R steam:steam /home/steam/local
else
	printf "OK\n"
fi

# TEST IF SUBFOLDER PRESENT
function update_ValidSubfolders () {
	#TODO:
}
update_ValidSubfolders
printf ""




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
