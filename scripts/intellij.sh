#!/bin/bash

source ./init.sh


install_intellij() {
    sudo snap remove intellij-idea-community --classic --edge
}

install_intellij_old() {


    # Fetch the most recent version
    ver=$(wget "https://www.jetbrains.com/intellij-repository/releases" -qO- | grep -P -o -m 1 "(?<=https://www.jetbrains.com/intellij-repository/releases/com/jetbrains/intellij/idea/BUILD/)[^/]+(?=/)")
    url="https://download.jetbrains.com/idea/ideaIC-${ver}.tar.gz"
    fileName="ideaIC-${ver}.tar.gz"

    if [ ! -f ${archive_dir}${fileName} ]; then
        echo "downloading intellij binary...${fileName}"

        sudo rm "${archive_dir}ideaIC*.tar.gz"
        sudo wget -q $url -O ${archive_dir}${fileName}
        sudo chmod 775 ${archive_dir}${fileName}

    fi

    if [ -d /opt/intellij ]; then
        sudo rm -r /opt/intellij
    fi

    sudo mkdir -p /opt/intellij

    sudo tar -xzf ${archive_dir}${fileName} --strip 1 -C /opt/intellij
    sudo ln -s /opt/intellij/bin/idea.sh /usr/bin/idea

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_intellij
fi
