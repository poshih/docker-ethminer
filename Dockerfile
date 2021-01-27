FROM nvidia/cuda:11.2.0-devel-ubuntu20.04

MAINTAINER nobody

WORKDIR /

ARG DEBIAN_FRONTEND=noninteractive

# Package and dependency setup
RUN apt update \
    && apt upgrade -y \    
    && apt-get install -y git \
     cmake \
     build-essential     
     
RUN nvidia-smi -pm 1 \
&& nvidia-smi -pl 105; \
exit 0
     
# Git repo set up
RUN git clone https://github.com/ethereum-mining/ethminer.git; \
    cd ethminer; \
    git submodule update --init --recursive; \
    mkdir build; \
    cd build; \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON; \
    cmake --build .; \
    make install;	
    
    

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
