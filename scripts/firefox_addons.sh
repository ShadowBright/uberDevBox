#!/bin/bash

source ./init.sh

if [ ! -n "$archive_dir" ]; then
    echo "archive directory not set!"
    exit 1
fi

reg_firefox_addon() {

    url="https://raw.githubusercontent.com/NicolasBernaerts/ubuntu-scripts/master/mozilla/mozilla-extension-manager"

    if [ ! -f ${archive_dir}mozilla-extension-manager ]; then
        echo "fetching file remotely..."

        sudo wget --header='Accept-Encoding:none' -O ${archive_dir}mozilla-extension-manager ${url}

    fi

    sudo chmod +x ${archive_dir}mozilla-extension-manager

    ${archive_dir}mozilla-extension-manager --system --install "$1"
}

reg_firefox_addon2() {

    URL_FIREFOX="https://addons.mozilla.org/firefox/"
    PATH_EXTENSION="/usr/lib/firefox-addons/extensions"

    cd /tmp
    sudo wget -O addon.xpi "$1"

    UID_TRY=`unzip -p addon.xpi install.rdf | grep "<em:id>" | head -n 1 | sed 's/^.*>\(.*\)<.*$/   \1/g' | xargs`

    if [ -z $UID_TRY ]; then
        UID_ADDON=$UID_TRY
    else
        #use filename
        UID_ADDON="$(echo $1| tr "/" "\n"|tail -1)"
    fi

    sudo mkdir -p "$PATH_EXTENSION/\{ec8030f7-c20a-464f-9b0e-13a3a9e97384\}/$UID_ADDON/"
    sudo unzip -q -o addon.xpi -d "$PATH_EXTENSION/$UID_ADDON"
    sudo rm addon.xpi

    sudo chown -R root:root "$PATH_EXTENSION/$UID_ADDON"
    sudo chmod -R a+rX "$PATH_EXTENSION/$UID_ADDON"

}

install_firefox_addons() {

    cd /tmp

    spFile="/etc/firefox/syspref.js"

    if [ -f ${spFile} ]; then
        sudo rm ${spFile} then
    fi

    sudo touch ${spFile}
    sudo chmod +x ${spFile}

    echo 'pref("general.config.obscure_value", 0);' | sudo tee -a /etc/firefox/syspref.js
    echo 'pref("general.config.filename", "firefox.cfg");'  | sudo tee -a /etc/firefox/syspref.js

    cfgFile="/usr/lib/firefox/firefox.cfg"

    if [ -f ${cfgFile} ]; then
        sudo rem ${cfgFile}
    fi

    sudo touch ${cfgFile}
    sudo chmod +x ${cfgFile}

    echo 'pref("browser.rights.3.shown", true);' | sudo tee -a ${cfgFile}
    echo 'pref("extensions.autoDisableScopes", 0);'  | sudo tee -a ${cfgFile}
    echo 'pref("extensions.enabledScopes", 15);' | sudo tee -a ${cfgFile}
    echo 'pref("browser.startup.page", 1);' | sudo tee -a ${cfgFile}
    echo 'pref("browser.startup.homepage", "http://www.google.com");' | sudo tee -a ${cfgFile}
    echo 'pref("browser.shell.checkDefaultBrowser", false);' | sudo tee -a ${cfgFile}
    echo 'pref("browser.search.defaultenginename", "Google");' | sudo tee -a ${cfgFile}
    echo 'clearPref("extensions.lastAppVersion");' | sudo tee -a ${cfgFile}
    echo 'lockPref("xpinstall.signatures.required", false);' | sudo tee -a ${cfgFile}
    echo 'lockPref("plugins.hide_infobar_for_outdated_plugin", true);' | sudo tee -a ${cfgFile}
    echo 'clearPref("plugins.update.url");' | sudo tee -a ${cfgFile}

    #ublock-origin
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/607454/addon-607454-latest.xpi

    #disconnect
    #reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/464050/addon-464050-latest.xpi

    #ghostery
    #reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/9609/addon-9609-latest.xpi

    #random-agent-spoofer
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/473878/addon-473878-latest.xpi

    #https-everywhere
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/229918/addon-229918-latest.xpi

    #noscript
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/722/addon-722-latest.xpi

    # tab memory usage
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/599152/addon-599152-latest.xpi

    # pure url
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/461912/addon-461912-latest.xpi

    # all tab helper
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/525044/addon-525044-latest.xpi

    # privacy settings
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/privacy-settings/addon-627512-latest.xpi

    # Google search link fix
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/google-search-link-fix/addon-351740-latest.xpi

    # no resource URI leak
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/no-resource-uri-leak/addon-706000-latest.xpi

    # clear flash cookies
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/file/781384/clear_flash_cookies-1.0.1-an+fx-linux.xpi

    #Decentraleyes
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/decentraleyes/addon-521554-latest.xpi

    #canvas blocker
    reg_firefox_addon https://addons.mozilla.org/firefox/downloads/latest/canvasblocker/addon-534930-latest.xpi
}



if [[ $0 == "$BASH_SOURCE" ]]; then
    #not souce so execute
    install_firefox_addons
fi
