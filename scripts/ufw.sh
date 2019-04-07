#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_ufw() {


    sudo apt-get install -y ufw gufw
    sudo ufw enable

	if [ "$fstab" -eq "0" ]; then
		 echo "# fstab being updated to secure shared memory"
		 sudo echo "tmpfs     /dev/shm     tmpfs     defaults,noexec,nosuid     0     0" >> /etc/fstab
	fi



}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_ufw
fi
