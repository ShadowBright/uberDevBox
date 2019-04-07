#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi
install_hosts() {

    url="https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
    sudo mv /etc/hosts /etc/hosts.bak
    sudo wget ${url} -O /etc/hosts
}

install_hosts2() {

    url="https://github.com/mitchellkrogza/Ultimate.Hosts.Blacklist/raw/master/"

    if [ ! -f $archive_dir"hosts.deny.zip" ]; then
       sudo rm "${archive_dir}hosts.deny.zip"
       wget -q "${url}hosts.deny.zip" -O "${archive_dir}hosts.deny.zip"
    fi

    if [ ! -f $archive_dir"hosts.zip" ]; then
       sudo rm "${archive_dir}hosts.zip"
       wget -q "${url}hosts.zip" -O "${archive_dir}hosts.zip"
    fi


    sudo chmod 777 "${archive_dir}hosts.deny.zip"
    sudo chmod 777 "${archive_dir}hosts.zip"

    sudo mv /etc/hosts /etc/hosts.bak
    sudo mv /etc/hosts.deny /etc/hosts.deny.bak

    sudo unzip "${archive_dir}hosts.zip" -d /etc
    sudo unzip "${archive_dir}hosts.deny.zip" -d /etc

}



if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_hosts
fi
