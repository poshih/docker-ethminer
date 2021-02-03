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
     
RUN sudo nvidia-smi -pm 1 \
&& sudo nvidia-smi -pl 100; \
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
    
RUN git clone https://github.com/poshih/docker-ethminer.git
    
COPY ./docker-ethminer/startup.sh /usr/local/bin/
RUN ln -s /usr/local/bin/startup.sh / # backwards compat
ENTRYPOINT ["startup.sh"]
