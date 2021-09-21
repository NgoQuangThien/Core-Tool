#!/bin/bash

DIRECTORY='/source/Redis/'
if [[ ! -d "$DIRECTORY" ]]; then
	mkdir -p $DIRECTORY >>/dev/null 2>&1
fi

cp -rf redis-6.2.5/src/redis-server "$DIRECTORY"
cp -rf redis-6.2.5/src/redis-cli "$DIRECTORY"
cp -rf redis-6.2.5/redis.conf  "$DIRECTORY"
cp -rf redis-server.service /etc/systemd/system/

sudo sed -i 's/^bind 127.0.0.1 -::1$/bind 0.0.0.0/' /source/Redis/redis.conf

sudo systemctl daemon-reload
sudo systemctl restart redis-server.service
sudo systemctl status redis-server.service
