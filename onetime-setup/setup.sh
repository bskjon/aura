#!/bin/bash

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


echo $password | sudo apt install tasksel -y
echo $password | sudo apt install \
    ffmpeg\
    speedtest \
    fzf



function raid() {
    echo $password | sudo ./raid.sh
}

function docker() {

    echo $password | sudo ./docker/install.sh
    sh ./docker/post.sh

}

function openresty() {
    echo $password | sudo ./openresty/install.sh
}

echo "Appending bashrc"
cat ./bashrc.template >> /home/$username/.bashrc
echo ""
echo "Done!"

