
# Ask for the user password
# Script only works if sudo caches the password for a few minutes
sudo true

init() {

    DEBIAN_FRONTEND=noninteractive

    if [ -d "/vagrant" ]; then
     root_dir="/vagrant"
    else

     if [ -d "scripts" ]; then
         root_dir="$(PWD)"
     else
       if [ -d "../scripts" ]; then
           root_dir="$(dirname "$PWD")"
       else
           root_dir="/tmp"
       fi
     fi
    fi

    echo "---------------------"
    echo "root dir : " $root_dir
    echo "---------------------"


    scripts_dir=${root_dir}"/scripts/"
    archive_dir=${scripts_dir}"archives/"

    if [ ! -d ${archive_dir} ]; then
     sudo mkdir ${archive_dir}
    fi

    #make sure any need archive downloaded is readable
    sudo chmod -R 555 ${archive_dir}

    source ${scripts_dir}basic.sh
    source ${scripts_dir}desktop.sh
    source ${scripts_dir}provisioning.sh
    source ${scripts_dir}browsers.sh
    source ${scripts_dir}tools.sh
    source ${scripts_dir}misc.sh
    source ${scripts_dir}antivirus.sh
    source ${scripts_dir}security.sh
}

run() {

    work
    home

    #remove tmp files
    sudo rm -rf /tmp/*
    sudo apt-get -q -y autoremove
}


work() {

    install_basic

    #--- browsers ---
    install_firefox
    install_chrome

    #--- desktops ---
    #install_ubuntu
    #install_gnome
    #install_mate
    #install_xubuntu

    # -- dev tools ---
    install_java
    install_scala
    install_python
    install_maven
    install_git
    install_eclipse
    install_atom
    install_dbtools
    install_vim
    install_pycharm
    install_node
    install_intellij

    #--- misc stuff ---
    install_yed
    #--- provisioning ----
    install_docker
    install_virtualbox

    #--- antivirus ----
    install_bd
    #install_avast

    #--- security ----
    install_hosts_blacklist

}


home() {

    #--- misc stuff ---
    install_spotify
    install_viber
    install_multimedia
    install_hexchat
    install_home_misc
    install_anki
    install_ring
    install_skype
    install_youtube_dl
    install_expressvpn
    install_steam
    install_dropbox
    install_insync
    install_riotim

}


init
#run
install_vagrant
