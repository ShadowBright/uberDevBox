#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_yed() {

    #NOTE: requires oracle java, not open jdk
    version="$(curl --silent https://www.yworks.com/products/yed | grep -Po 'productVersion\"\>([0-9.]+)\<' | grep -Po '[0-9.]+')"
    fileName="yEd-${version}.zip"

    #fileName="$(curl --silent https://www.yworks.com/downloads | grep -Po 'yEd-.*zip')"
    prodName=${fileName%.*}

    if [ ! -f ${archive_dir}${fileName} ]; then
        echo "Downloading $fileName ..."
        sudo wget -q http://www.yworks.com/products/yed/demo/${fileName} -O ${archive_dir}${fileName}
    fi

    if [ -d "/opt/yed" ]; then
        sudo rm -r /opt/yed*
    fi

    if [[ ! -f ${archive_dir}${fileName} ]]; then
        echo "Unable to find archive ${archive_dir}${fileName}...aborting.."
        exit 1
    fi

    sudo unzip -q -o ${archive_dir}${fileName}  -d "/opt"
    sudo mv /opt/${prodName,,} /opt/yed
    sudo chmod -R 775 /opt/yed

    sudo cp ${scripts_dir}yed.desktop /usr/share/applications/
    sudo chmod +x /usr/share/applications/yed.desktop

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_yed
fi
