#!/bin/bash

cwd=$(dirname $(realpath -s $0))


echo "
  _____  ______  _______  _    _  _____  
 / ____||  ____||__   __|| |  | ||  __ \ 
| (___  | |__      | |   | |  | || |__) |
 \___ \ |  __|     | |   | |  | ||  ___/ 
 ____) || |____    | |   | |__| || |     
|_____/ |______|   |_|    \____/ |_|     
                                       

"
username=$(whoami)
sudo -k

read -s -p "[sudo] password for $USER: " password
until (echo $password | sudo -S echo '' 2>/dev/null)
do
    echo -e '\nSorry, try again.'
    read -s -p "[sudo] password for $USER: " password
done

echo $password | sudo chmod u+x **/*.sh

echo $password | sudo apt install tasksel -y
echo $password | sudo apt install -y \
    ffmpeg\
    speedtest-cli \
    fzf



function raid() {
    echo $password | sudo $cwd/raid.sh
}

function docker() {

    echo $password | sudo $cwd/docker/install.sh
    echo $password | sudo groupadd docker
    echo $password | sudo usermod -aG docker $username

}

function openresty() {
    echo $password | sudo $cwd/openresty/install.sh
}

function netplan() {
    echo $password | sudo $cwd/netplan/install.sh
}

raid
docker
openresty

echo "Appending bashrc"
cp /home/$username/.bashrc /home/$username/.bashrc.default
cat ./bashrc.template >> /home/$username/.bashrc
echo ""
echo "Done!"

