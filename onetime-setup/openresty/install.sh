#!/bin/sh

cwd=$(dirname $(realpath -s $0))

echo "
  ____   _____   ______  _   _  _____   ______   _____  _______ __     __
 / __ \ |  __ \ |  ____|| \ | ||  __ \ |  ____| / ____||__   __|\ \   / /
| |  | || |__) || |__   |  \| || |__) || |__   | (___     | |    \ \_/ / 
| |  | ||  ___/ |  __|  |     ||  _  / |  __|   \___ \    | |     \   /  
| |__| || |     | |____ | |\  || | \ \ | |____  ____) |   | |      | |   
 \____/ |_|     |______||_| \_||_|  \_\|______||_____/    |_|      |_|   

"

echo "Installing OpenResty dependencys"

apt-get -y install --no-install-recommends wget gnupg ca-certificates


wget -O - https://openresty.org/package/pubkey.gpg | sudo apt-key add -
echo "deb http://openresty.org/package/ubuntu $(lsb_release -sc) main" \
    | sudo tee /etc/apt/sources.list.d/openresty.list


echo "Updating"
apt -y update

echo "Installing OpenResty"
apt -y install openresty

echo "Using pre-configured setup"
cp -r $cwd/web-config/* /usr/local/openresty/nginx/

openresty -V


echo "Installing LuaRocks + Auto SSL"
apt -y install luarocks make
luarocks install lua-resty-auto-ssl

echo "Installing Certbot"
apt -y install certbot

mkdir -p /etc/ssl/auto/

openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 \
-subj '/CN=sni-support-required-for-valid-ssl' \
-keyout /etc/ssl/auto/resty-auto-ssl-fallback.key \
-out    /etc/ssl/auto/resty-auto-ssl-fallback.crt

sudo systemctl enable openresty
sudo systemctl start openresty