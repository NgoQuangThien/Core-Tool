#!/bin/bash

DIRECTORY='/source/Redis/redis-pull/'
if [[ ! -d "$DIRECTORY" ]]; then
	sudo mkdir -p $DIRECTORY >>/dev/null 2>&1
fi

pip3 install redis-4.1.4-py3.whl

sudo cp -rf redis-pull.py "$DIRECTORY"
sudo cp -rf redis-pull.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl restart redis-pull.service
sudo systemctl status redis-pull.service
