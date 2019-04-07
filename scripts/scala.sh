#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_scala() {


    if [ ! -f $archive_dir"scala.deb" ]; then

        sudo wget -q http://www.scala-lang.org/files/archive/scala-2.11.8.deb -O $archive_dir"scala.deb"

    fi

    sudo dpkg -i $archive_dir"scala.deb"

    echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
    sudo apt-get -qq update
    sudo apt-get -qq -y install sbt

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_scala
fi
