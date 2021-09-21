#!/bin/bash

echo -e 'Check your OS \n'
CentOS=$(hostnamectl | grep 'CentOS')
Ubuntu=$(hostnamectl | grep 'Ubuntu')

echo -e 'Install required packages if it is missing!!! \n'
if [[ $CentOS ]]; then
	sudo yum -y groupinstall 'Development Tools' >>/dev/null 2>&1
fi
if [[ $Ubuntu ]]; then
	sudo apt -y install build-essential >>/dev/null 2>&1
fi

echo -e 'Extract the source file \n'
tar xzf redis-6.2.5.tar.gz

echo -e 'Making Redis... \n'
cd redis-6.2.5
make >>/dev/null 2>&1

echo '-----------------DONE-----------------'
