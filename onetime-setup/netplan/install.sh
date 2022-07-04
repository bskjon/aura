#!/bin/sh

cwd=$(dirname $(realpath -s $0))

echo "
 _   _  ______  _______ __          __  ____   _____   _  __
| \ | ||  ____||__   __|\ \        / / / __ \ |  __ \ | |/ /
|  \| || |__      | |    \ \  /\  / / | |  | || |__) || ' / 
|     ||  __|     | |     \ \/  \/ /  | |  | ||  _  / |  <  
| |\  || |____    | |      \  /\  /   | |__| || | \ \ | . \ 
|_| \_||______|   |_|       \/  \/     \____/ |_|  \_\|_|\_\
"


mv /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.yaml.bak
cp $cwd/network-config/00-installer-config.yaml /etc/netplan/

cp $cwd/network-config/24-vlan.yaml /etc/netplan/

netplan --debug generate
netplan try