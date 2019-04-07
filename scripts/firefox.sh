#!/bin/bash

source ./init.sh
source ./firefox_addons.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_firefox_manual() {
    # Skip if already installed
    #firefox -version && exit 0

    sudo apt-get -qq -y remove firefox
    sudo apt-get -qq -y install zenity-common zenity

    if [ -f "/usr/lib/firefox/firefox" ]; then
       major=`firefox -version | cut -d. -f1 | cut -d ' ' -f3`
    else
       major="0"
    fi

   echo "Firefox Major version : " $major

   if [ $major -lt "45" ]; then

        if [ ! -f ${archive_dir}firefox.tar.bz2 ]; then
            sudo wget -q "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" -O firefox.tar.bz2 -O ${archive_dir}/firefox.tar.bz2 >NUL

            #sudo wget -q  https://ftp.mozilla.org/pub/firefox/releases/45.0.2/linux-x86_64/en-US/firefox-45.0.2.tar.bz2 -O ${archive_dir}/firefox.tar.bz2 >NUL
            sudo chmod 555 ${archive_dir}/firefox.tar.bz2
        fi

        if [ -d "/usr/lib/firefox" ]; then
           sudo rm -r /usr/lib/firefox
        fi

        sudo mkdir /usr/lib/firefox
        sudo tar -xjf ${archive_dir}firefox.tar.bz2 -C /usr/lib
        sudo rm /usr/bin/firefox
        sudo ln -s /usr/lib/firefox/firefox /usr/bin/firefox

        sudo cp ${scripts_dir}firefox.desktop /usr/share/applications/
        sudo chmod +x /usr/share/applications/firefox.desktop

    fi

}

install_firefox() {

    DEBIAN_FRONTEND=noninteractive

    sudo apt-get -qq -y remove firefox

    if [ -d "/etc/firefox" ]; then
       sudo rm -r /etc/firefox
       echo "deleting /etc/firefox..."
    fi

    if [ -d "/usr/lib/firefox" ]; then
        sudo rm -r /usr/lib/firefox
        echo "deleting /usr/lib/firefox"
    fi

    if [ -d "/usr/lib/firefox-addons" ]; then
        sudo rm -r /usr/lib/firefox-addons
        echo "deleting /usr/lib/firefox-addons..."
    fi

    if [ -d "~/.mozilla" ]; then
       sudo rm -r ~/.mozilla
       echo "deleting ~/.mozilla..."
    fi

    if [ -d "/usr/lib/mozilla" ]; then
       sudo rm -r /usr/lib/mozilla
       echo "deleting /usr/lib/mozilla..."
    fi

    sudo apt-get -qq -y install firefox zenity-common zenity

    install_firefox_addons
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_firefox
fi
