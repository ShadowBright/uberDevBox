#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_youtube_dl() {

    sudo curl -s -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod a+rx /usr/local/bin/youtube-dl
    sudo rm -f /usr/local/bin/youtube_mp3
    sudo echo "youtube-dl --download-archive downloaded.txt --no-post-overwrites -ciwx -o '%(title)s.%(ext)s' --extract-audio --audio-format mp3 $1" | sudo tee -a /usr/local/bin/youtube_mp3
    sudo chmod a+rx /usr/local/bin/youtube_mp3


}

if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_youtube_dl
fi
