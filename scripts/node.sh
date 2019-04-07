#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_node() {

    fileName="$(curl -s https://nodejs.org/dist/latest/ | grep -oP '(node-v.+-linux-x64.tar.gz)(?=")')"

    if [ ! -f ${archive_dir}${fileName} ]; then

        sudo rm ${archive_dir}/node*.gz
        sudo wget --no-check-certificate -q -O ${archive_dir}${fileName} https://nodejs.org/dist/latest/${fileName}
        sudo chmod 775 ${archive_dir}${fileName}
    fi

    if [ -d /usr/lib/node ]; then
       sudo rm -r /usr/lib/node
    fi

    sudo mkdir -p /usr/lib/node

    sudo tar --strip-components 1 -zxf ${archive_dir}${fileName} -C /usr/lib/node

    if [ -L /usr/bin/node ]; then
        sudo rm /usr/bin/node
    fi

    if [ -L /usr/bin/npm ]; then
        sudo rm /usr/bin/npm
    fi

    sudo ln -s /usr/lib/node/bin/node /usr/bin/node
    sudo ln -s /usr/lib/node/bin/npm /usr/bin/npm

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_node
fi
