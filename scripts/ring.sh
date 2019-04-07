#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_ring() {

		VER=$(lsb_release -sr)
	    sudo sh -c "echo 'deb https://dl.ring.cx/ring-nightly/ubuntu_${VER}/ ring main' > /etc/apt/sources.list.d/ring-nightly-main.list"
		sudo apt-key adv --keyserver hkp://pgp.mit.edu:80 --recv-keys A295D773307D25A33AE72F2F64CD5FA175348F84
		sudo add-apt-repository universe
		sudo apt-get -qq update && sudo apt-get -qq -y install ring

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_ring
fi
