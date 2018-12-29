#!/usr/bin/env bash

HOST=`hostname`
config="$HOST.nix"
hardware="$HOST-hardware.nix"

if [[ ! -e "hosts/$config" ]]; then
  echo "$config file is missing" >&2
  exit 1
fi

if [[ ! -e "hosts/$hardware" ]];then
  echo "$hardware file is missing" >&2
  exit 2
fi

ln -f "hosts/$config" configuration.nix
ln -f "hosts/$hardware" hardware-configuration.nix

exit 0
