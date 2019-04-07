#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

gset(){

    gsettings set org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:$1/ $2 $3
}

install_post() {

    uid="$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d \')"
    gset "${uid}" use-theme-colors false
    gset "${uid}" "background-color" "'#000000000000'"
    gset "${uid}" "foreground-color"  "'#00FF00'"
    gset "${uid}" "background-type"  "'transparent'"
}

install_firsttime() {

    #all new users should get this script
    postFile="post.sh"
    sudo cp ${scripts_dir}${postFile} /etc/skel
    echo "if [ -f ~/${postFile} ]; then sh ~/${postFile} ; rm ~/${postFile} ; fi" | sudo tee -a /etc/skel/.profile

    # copy for vagrant user
    cp ${scripts_dir}${postFile} /home/vagrant/
    echo "if [ -f ~/${postFile} ]; then sh ~/${postFile} ; rm ~/${postFile} ; fi" | tee -a /home/vagrant/.profile

    sudo useradd developer -m -s /bin/bash
    echo developer:codemonkey | sudo chpasswd
    echo 'developer  ALL=(ALL:ALL) ALL' | sudo tee -a /etc/sudoers

    #https://askubuntu.com/questions/285689/increase-mouse-wheel-scroll-speed
    if [ -f iamwheelrc ]; then
       cp ${scripts_dir}iamwheelrc ~/.iamwheelrc
       #run 'iamwheel -b "4 5"'
    fi

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_post
fi
