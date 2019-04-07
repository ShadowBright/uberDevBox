#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_duplicati() {

    sudo apt-get -qq -y install mono-runtime
	fileName="duplicati_2.0.2.1-1_all.deb"

	if [ ! -f ${archive_dir}${fileName} ]; then

        sudo wget -q https://updates.duplicati.com/beta/${fileName} -O ${archive_dir}${fileName}

    fi

    sudo dpkg -i ${archive_dir}${fileName}

	sudo systemctl enable duplicati

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_app
fi
