#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_git() {


     sudo apt-get -qq -y install git gitg

     wget -q – http://github.com/nvie/gitflow/raw/develop/contrib/gitflow-installer.sh –no-check-certificate -P /tmp
     sudo chmod a+x /tmp/gitflow-installer.sh
     sudo sh /tmp/gitflow-installer.sh

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_git
fi
