#!/bin/sh

groupadd docker
usermod -aG docker $(whoami)

echo ""
echo "Done!"