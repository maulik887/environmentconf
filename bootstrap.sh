#!/bin/sh

apt update

echo "Installing python3-pip..."
apt-get install -y python3-pip

echo "Installing python3-pip..."
apt-get install -y ssh

echo "installing environmentconf"
pip3 install environmentconf
