#!/bin/bash

DATE=$(date +%Y%m%d)

# Check plex server version // if the version is not up-to-date, then downloaad the update and install.

INSTALLVERSION=$(ps -ef | grep -- --server-version | head -n 1 | awk '{ print $13 }')
UPDATEVERSION=$(curl -s "https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu" | awk -F "_" '{ print $2 }')

echo -e "Installed Version:\t$INSTALLVERSION"
echo -e "Up-to-date Verions:\t$UPDATEVERSION"

if [ "$INSTALLVERSION" == "$UPDATEVERSION" ]; then
        echo "The version of Plex Media Server you have installed is up-to-date."
        exit 0
else
        wget -O ~/Downloads/plex-update-$DATE.deb "https://plex.tv/downloads/latest/1?channel=16&build=linux-ubuntu-x86_64&distro=ubuntu"
        sudo dpkg -i ~/Downloads/plex-update-$DATE.deb
fi
