#!/bin/bash

source ./init.sh

install_java() {

    sudo add-apt-repository -y ppa:webupd8team/java
    sudo apt-get -qq -y update

    echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections
    echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections

    sudo apt-get -qq -y install oracle-java8-set-default
    #sudo apt-get -qq -y install oracle-jdk7-installer
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_java
fi
