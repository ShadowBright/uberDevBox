#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_basic() {

    sudo apt-get -qq update && sudo apt-get -qq dist-upgrade

    #disables IPv6 due to archive.ubuntu.com calls freezing or being extremely slow
    echo "#disable ipv6" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf
    sudo sysctl -p

    sudo apt-add-repository -y ppa:teejee2008/ppa
    sudo apt-get -qq update
    #sudo apt-get -y -qq upgrade

    #--- req stuff ---
    sudo apt-get -qq -y install \
                            curl \
                            wget \
                            vim \
                            htop \
                            screen \
                            gdebi-core \
                            openjdk-8-jre \
                            build-essential \
                            virtualbox-guest-dkms \
                            virtualbox-guest-utils \
                            virtualbox-guest-x11 \
                            libxext-dev \
                            libxrender-dev \
                            libxtst-dev \
                            net-tools \
                            okular \
                            oktela

     #--- misc tools ---
     sudo apt-get -qq -y install \
              xarchiver \
              filezilla \
              cifs-utils \
              w3m \
              w3m-img \
              gufw

     sudo apt-get -qq -y install \
                         p7zip-rar \
                         p7zip-full \
                         unace \
                         unrar \
                         zip \
                         unzip \
                         sharutils \
                         rar \
                         uudeview \
                         mpack \
                         arj \
                         cabextract \
                         file-roller \
			            iamwheel \
			            resolvconf


    #setting base should work, but doesnt...
    #echo 'nameserver 8.8.8.8' | sudo tee -a  /etc/resolvconf/resolv.conf.d/base
    #echo 'nameserver 8.8.4.4' | sudo tee -a  /etc/resolvconf/resolv.conf.d/base
    #setting head works...but isnt recommend
    echo 'nameserver 8.8.8.8' | sudo tee -a  /etc/resolvconf/resolv.conf.d/head
    echo 'nameserver 8.8.4.4' | sudo tee -a  /etc/resolvconf/resolv.conf.d/head

    #trying to ignore dhcp given DNS entries
    echo 'supersede domain-name-servers 8.8.8.8, 8.8.4.4;' | sudo tee -a /etc/dhcp/dhclient.conf

    sudo resolvconf -u

    #just to be sure
    #echo 'dns-nameservers 8.8.8.8 8.8.4.4' | sudo tee -a /etc/network/interfaces
    #sudo service networking restart

    #sudo apt-get --qq autoremove

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_basic
fi
