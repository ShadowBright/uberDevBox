#!/bin/bash

source ./init.sh

install_atom () {

    ATOM_VERSION=$(curl -s https://github.com/atom/atom/releases/latest | egrep -o "v[0-9]*\.[0-9]*\.[0-9]")

    ATOM_LINK="https://atom-installer.github.com/${ATOM_VERSION}/atom-amd64.deb"
    ATOM_ARCHIVE="${archive_dir}atom_${ATOM_VERSION}.deb"

    #https://atom.io/download/deb
    echo "Latest ATOM version is $ATOM_VERSION"

    if [ ! -f ${ATOM_ARCHIVE} ]; then

       sudo rm "${archive_dir}atom*.deb"
       #wget -q "https://github.com/atom/atom/releases/download/${ATOM_VERSION}/atom-amd64.deb" -O "${archive_dir}atom_${ATOM_VERSION}.deb"
       wget -q ${ATOM_LINK} -O ${ATOM_ARCHIVE}

    fi

    sudo chmod 777 "${archive_dir}atom_${ATOM_VERSION}.deb"

    sudo dpkg --remove atom
    sudo gdebi -qn "${archive_dir}atom_${ATOM_VERSION}.deb"

    sudo cp ${scripts_dir}atom.desktop /usr/share/applications/
    sudo chmod +x /usr/share/applications/atom.desktop
    sudo apm install linter-pylint linter-jshint linter-php linter-phpcs linter-phpmd linter-scss-lint linter-csslint linter-js-yaml linter-tidy linter-htmlhint atom-beautify minimap color-picker file-icons autocomplete-python python-tools ask-stack git-plus open-recent autocomplete-paths tablr autoclose-html emmet
}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_atom
fi
