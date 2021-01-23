FROM nvidia/cuda:11.1-devel-ubuntu18.04

MAINTAINER nobody

WORKDIR /

# Package and dependency setup
RUN apt update \
    && apt upgrade -y \    
    && apt-get install -y git \
     cmake \
     build-essential
     
# Git repo set up
RUN git clone https://github.com/ethereum-mining/ethminer.git; \
    cd ethminer; \
    git checkout tags/v0.19.0; \
	git submodule update --init --recursive; \
    mkdir build; \
    cd build; \
    cmake .. -DETHASHCUDA=ON -DETHASHCL=OFF -DETHSTRATUM=ON; \
    cmake --build .; \
    make install;	

ENTRYPOINT ["/usr/local/bin/ethminer", "-U"]
