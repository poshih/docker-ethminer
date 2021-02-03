#!/bin/bash
set -e

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    sudo nvidia-smi -pl 220
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

sudo nvidia-smi -pm 1
sudo nvidia-smi -pl 110

"${@}" &

#Wait
wait $!

#Cleanup
cleanup
