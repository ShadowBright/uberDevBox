#!/bin/bash

source ./init.sh

install_maven() {
    cd /tmp
    # install maven

    export M2_VER=$(curl -s https://www.apache.org/dist/maven/maven-3/ | egrep -o "[0-9]*\.[0-9]*\.[0-9]" | tail -1)
    filename="apache-maven-${M2_VER}-bin.tar.gz"
    url="https://www.apache.org/dist/maven/maven-3/${M2_VER}/binaries/${filename}"

    sudo rm ${archive_dir}maven*

    if [ ! -f ${archive_dir}${filename} ]; then
    	sudo wget --quiet $url –no-check-certificate -P ${archive_dir}
    fi

    if [ ! -f ${archive_dir}${filename} ]; then
       echo "$url not found...aborting..."
       return 1
    fi

    sudo apt-get -qq -y remove maven

    sudo tar xzf ${archive_dir}${filename} -C /usr/local

    sudo ln -s /usr/local/apache-maven-${M2_VER} maven
    sudo unlink /usr/local/bin/mvn
    sudo ln -s /usr/local/maven/bin/mvn /usr/local/bin/mvn

    export M2_HOME=/usr/local/maven
    export PATH=$PATH:$M2_HOME/bin

    if [ -f /etc/profile.d/maven.sh ]; then
	sudo rm /etc/profile.d/maven.sh
    fi

    echo 'export M2_HOME=/usr/local/maven' | sudo tee -a  /etc/profile.d/maven.sh
    echo 'export PATH=$PATH:$M2_HOME/bin' | sudo tee -a  /etc/profile.d/maven.sh

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_maven
fi
