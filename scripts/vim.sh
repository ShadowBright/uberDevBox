#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_vim() {

    sudo apt-get -qq -y install vim-nox tmux

    #Set the Vundle
    if [ -d /etc/vim/bundle ]; then
       sudo rm -r /etc/vim/bundle
    fi

    sudo mkdir /etc/vim/bundle

    sudo git clone http://github.com/gmarik/vundle.git /etc/vim/bundle/vundle


    if [ -d ~/.vim_runtime ]; then
       rm -r ~/.vim_runtime
    fi

    git clone https://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh

    echo "Plugin 'derekwyatt/vim-scala'" >> ~/.vimrc

    vim -E -s -c 'PluginInstall' -c 'qall' -c 'qa!'
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_vim
fi
