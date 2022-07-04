#!/bin/sh

echo "

    _____    ____    _____  ______  _  __ _____  
    |  __ \  / __ \  / ____||  ____|| |/ /|  __ \ 
    | |  | || |  | || |     | |__   | ' / | |__) |
    | |  | || |  | || |     |  __|  |  <  |  _  / 
    | |__| || |__| || |____ | |____ | . \ | | \ \ 
    |_____/  \____/  \_____||______||_|\_\|_|  \_\


"

# Requires sudo
apt update
apt install ca-certificates curl gnupg lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

apt update
apt install -y docker-ce docker-ce-cli containerd.io


# Docker compose
version=$(basename $(curl -fs -o/dev/null -w %{redirect_url} https://github.com/docker/compose/releases/latest))
curl -L "https://github.com/docker/compose/releases/download/$version/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

docker-compose --version

systemctl enable docker.service
systemctl enable containerd.service
