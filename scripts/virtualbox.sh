#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_virtualbox () {

    #sudo rm /etc/apt/sources.list.d/virtualbox.list*
    #sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian $(lsb_release -sc) contrib" >> /etc/apt/sources.list.d/virtualbox.list'
    #wget -q http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
    #sudo apt -qq update
    #sudo apt install -qq -y --force-yes virtualbox-5.1


    codename="$(lsb_release -c | sed 's/.*Codename:\W\(.*\)/\1/')"

    #found ver2 option *after* I did the ver approach
    #ver2=$(wget -qO - http://download.virtualbox.org/virtualbox/LATEST.TXT)
    ver="$(curl -s http://download.virtualbox.org/virtualbox | grep -oP '(\d+\.\d+\.\d+)(?=/)' | sort --version-sort | tail -1)"

    url="http://download.virtualbox.org/virtualbox/${ver}"
    vfile="virtualbox-.*${codename}_amd64.deb"

    #echo "${codename}"
    #echo "${url}"
    #echo "${vfile}"

    fileName=$(eval "curl -s http://download.virtualbox.org/virtualbox/${ver} | grep -oP '(?<=>)virtualbox-.*${codename}_amd64.deb'")

    extpackFile="Oracle_VM_VirtualBox_Extension_Pack-${ver}.vbox-extpack"

    if [ ! -f ${archive_dir}${fileName} ]; then

	echo "Downloading... ${fileName} ..."
        sudo rm "${archive_dir}virtualbox*"
    	sudo wget -O ${archive_dir}${fileName} -q http://download.virtualbox.org/virtualbox/${ver}/${fileName}
	sudo chmod 775 ${archive_dir}${fileName}
    fi


    if [ ! -f ${archive_dir}${extpackFile} ]; then

    	sudo rm "${archive_dir}Oracle_VM_VirtualBox_Extension_Pack*"
	echo "Downloading ${extpackFile} ..."
    	sudo wget -O ${archive_dir}${extpackFile} -q http://download.virtualbox.org/virtualbox/${ver}/${extpackFile}
        sudo chmod 775 ${archive_dir}${extpackFile}
    fi

    sudo apt remove -y -qq virtualbox*
    #sudo dpkg --remove virtualbox
    sudo gdebi -qn "${archive_dir}${fileName}"

    #virtual box required ext pack keep the full name
    sudo VBoxManage extpack install ${archive_dir}${extpackFile} --accept-license=715c7246dc0f779ceab39446812362b2f9bf64a55ed5d3a905f053cfab36da9e


    #sudo sh -c 'echo "GRUB_CMDLINE_LINUX='cgroup_enable=memory swapaccount=1'" >> /etc/default/grub'
    #sed "s/GRUB_CMDLINE_LINUX=\"\(.*\)\"/GRUB_CMDLINE_LINUX=\"\1 cgroup_enable=memory swapaccount=1\"/" /etc/default/grub
}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_virtualbox
fi
