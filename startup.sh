#!/bin/bash
set -e

#Define cleanup procedure
cleanup() {
    echo "Container stopped, performing cleanup..."
    sudo nvidia-smi -pl 220
}

#Trap SIGTERM
trap 'cleanup' SIGTERM

"${@}" &

#Wait
wait $!

#Cleanup
cleanup
