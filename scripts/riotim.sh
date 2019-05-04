source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

install_riotim() {

sudo apt install -y lsb-release wget apt-transport-https
sudo wget -O /usr/share/keyrings/riot-im-archive-keyring.gpg https://packages.riot.im/debian/riot-im-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/riot-im-archive-keyring.gpg] https://packages.riot.im/debian/ $(lsb_release -cs) main" |
    sudo tee /etc/apt/sources.list.d/riot-im.list
sudo apt-get --qq update
sudo apt-get -qq -y  install riot-web

}


if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_riotim
fi

