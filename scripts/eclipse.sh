#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_eclipse() {

   if [ -d /opt/eclipse ]; then
       sudo rm -r /opt/eclipse
   fi

   if [ ! -f $archive_dir"eclipse.tar.gz" ]; then

       sudo wget -q -O ${archive_dir}eclipse.tar.gz http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/R/eclipse-reporting-neon-R-linux-gtk-x86_64.tar.gz

   fi

   sudo mkdir /opt/eclipse
   sudo tar -zxvf ${archive_dir}eclipse.tar.gz -C /opt

   sudo cp ${scripts_dir}eclipse.desktop /usr/share/applications/
   sudo chmod +x /usr/share/applications/eclipse.desktop
   sudo cp ${scripts_dir}eclipse.desktop /usr/local/share/applications/
   sudo chmod +x /usr/local/share/applications/eclipse.desktop
   sudo cp ${script_dir}eclipse.ini /opt/eclipse

   export PATH=$PATH:/opt/eclipse
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_eclipse
fi
