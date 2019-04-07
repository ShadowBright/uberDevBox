#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_app
fi
