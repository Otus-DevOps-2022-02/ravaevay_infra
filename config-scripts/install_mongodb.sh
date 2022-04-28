#!/bin/sh
wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.2.list
while pgrep -a apt; do echo 'Waiting for apt...'; sleep 1; done
sudo apt-get update && sudo apt-get install -y apt-transport-https ca-certificates && sudo apt-get install -y mongodb-org && sudo systemctl start mongod && sudo systemctl enable mongod
