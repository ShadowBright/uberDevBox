#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_chromium() {
    sudo apt -qq -y install chromium-browser
}

install_chrome() {
     sudo rm /etc/apt/sources.list.d/google.list

     sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list'
     sudo wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
     sudo apt-get -qq update
     sudo apt-get -qq -y install google-chrome-stable
}

install_chrome_manual() {

    if [ ! -f $archive_dir"chrome.deb" ]; then

        sudo wget -q -O ${archive_dir}chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
        sudo chmod 555 ${archive_dir}chrome.deb
    fi

    sudo dpkg -i ${archive_dir}chrome.deb

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_chromium
fi
