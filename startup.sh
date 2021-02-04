#!/bin/bash
set -e

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    sudo nvidia-smi -pl 220
    exit 0
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

sudo nvidia-smi -pm 1
sudo nvidia-smi -pl 110

"${@}" &

while true; do :; done
