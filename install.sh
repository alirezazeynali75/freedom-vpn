#!/bin/bash

function isRoot() {
	if [ "$EUID" -ne 0 ]; then
		return 1
	fi
}

function initialCheck() {
	if ! isRoot; then
		echo "Sorry, you need to run this as root"
		exit 1
	fi
}

function install() {
  apt update
  apt install snapd
  apt install core
  apt install gost
  apt install screen
}

function config() {
  echo "What is remote ss url? [ss://method:password@host:port]"
  read remote
  ip = `curl icanhazip.com`
  echo "Enter method"
  read method
  echo "Enter password"
  read password
  echo "Enter port"
  read port
  gost -L=ss://$method:$password@:$port -F=$remote
}

initialCheck

install

config