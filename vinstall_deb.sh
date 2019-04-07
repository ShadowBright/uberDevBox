#!/bin/bash

ver=$(wget "https://releases.hashicorp.com/vagrant" -qO- | grep -P -o -m 1 "(?<=vagrant_)[^/]+(?=</)")

url="https://releases.hashicorp.com/vagrant/${ver}/"
fileName="vagrant_${ver}_x86_64.deb"

if [ ! -f ${fileName} ]; then

	echo "downloading vagrant binary...${fileName}"

	sudo rm "vagrant*_x86_64.deb"
	sudo wget -q ${url}${fileName} -O ${fileName}

fi

sudo dpkg -r vagrant
sudo dpkg -i ${fileName}

vagrant plugin install vagrant-vbguest
