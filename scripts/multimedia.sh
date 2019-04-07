#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_multimedia() {

    sudo apt-get -qq -y  install ffmpeg \
                         libdvdread4 \
                         icedax \
                         libdvd-pkg \
                         easytag \
                         id3tool \
                         lame \
                         libxine2-ffmpeg \
                         nautilus-script-audio-convert \
                         libmad0 \
                         mpg321 \
                         libavcodec-extra \
                         gstreamer1.0-libav \
                         flashplugin-installer \
                         vlc \
                         smplayer \
			             gimp \
                         cmus \
                         xfburn

}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_multimedia
fi
