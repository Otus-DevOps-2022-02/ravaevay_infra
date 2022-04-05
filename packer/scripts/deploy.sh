#!/bin/sh
sudo apt install -y git
cd ~
git clone -b monolith https://github.com/express42/reddit.git
cd reddit
bundle install
sudo systemctl daemon-reload
sudo systemctl start puma
sudo systemctl enable puma
