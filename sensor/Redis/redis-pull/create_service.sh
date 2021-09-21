#!/bin/bash

DIRECTORY='/source/Redis/redis-pull/'
if [[ ! -d "$DIRECTORY" ]]; then
	mkdir -p $DIRECTORY >>/dev/null 2>&1
fi

cp -rf redis-pull.sh "$DIRECTORY"
cp -rf redis-pull.service /etc/systemd/system/

chmod +x /source/Redis/redis-pull/redis-pull.sh

sudo systemctl daemon-reload
sudo systemctl restart redis-pull.service
sudo systemctl status redis-pull.service
