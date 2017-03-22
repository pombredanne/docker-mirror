#!/bin/bash

# Name: init.sh
# Description: Initialize a Docker Registry as a pull through cache.
#
# Copyright (C) Cameron Malek 2017

VERSION="0.0.2"

# Global Variables
EXIT_STATUS=0

DIR=$(pwd)

################
# Script Start #
################

# Build necessary images then run in background
docker-compose up -d

cd ~/Library/Containers/com.docker.docker/Data/database/
git reset -- com.docker.driver.amd64-linux
git checkout -- com.docker.driver.amd64-linux
cd com.docker.driver.amd64-linux
echo '{"registry-mirrors":["http:\/\/localhost:5000"],"debug":true,"storage-driver":"aufs","insecure-registries":["localhost:5000"]}' > etc/docker/daemon.json
git add etc/docker/daemon.json
git commit -m 'configuration for registry push through cache'
cd $DIR

echo "Configured docker hub registry"

exit ${EXIT_STATUS}

