#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_dbtools() {

	if [ ! -f $archive_dir"dbeaver.deb" ]; then

		wget -q -c http://dbeaver.jkiss.org/files/dbeaver-ce_latest_amd64.deb -O ${archive_dir}dbeaver.deb
	fi

	sudo dpkg -i ${archive_dir}dbeaver.deb
	sudo apt-get -qq -y install -f

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_dbtools
fi
