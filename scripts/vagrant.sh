#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_vagrant() {

     rootPath="https://releases.hashicorp.com/vagrant/"
     ver="$(curl -s $rootPath | grep -oP "\d.\d.\d" | sort | tail -1)"
     filePath="${rootPath}${ver}/"
     fileName="vagrant_${ver}_x86_64.deb"

     if [ ! -f ${archive_dir}${fileName} ];then
         sudo rm -f ${archive_dir}/vagrant*.deb
         echo "pulling ${filePath}${fileName}"
         sudo wget --no-check-certificate -q -O ${archive_dir}${fileName} ${filePath}${fileName}
         sudo chmod 775 ${archive_dir}${fileName}
     fi

     sudo dpkg --remove vagrant
     sudo gdebi -qn "${archive_dir}${fileName}"
     vagrant plugin repair
     vagrant plugin install vagrant-vbguest
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_vagrant
fi
