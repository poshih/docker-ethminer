#!/bin/bash

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

ethminer --report-hashrate -U -P stratum1+tcp://0xA494F07b0Cd0315903d2461c10AED0246477A759.docker_$(cat /etc/hostname)@us2.ethermine.org:4444 &

while true;
do 
sleep 2
done
