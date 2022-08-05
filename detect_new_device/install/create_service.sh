#!/bin/bash

DIRECTORY='/source/bids/detect_new_device/'
if [[ ! -d "$DIRECTORY" ]]; then
	mkdir -p $DIRECTORY >>/dev/null 2>&1
fi

cp -rf ../main.py "$DIRECTORY"
cp -rf ../lib "$DIRECTORY"
cp -rf ../device.list "$DIRECTORY"
cp -rf bids-newdevice.service /etc/systemd/system/

sudo systemctl daemon-reload
sudo systemctl restart bids-newdevice.service
sudo systemctl status bids-newdevice.service

