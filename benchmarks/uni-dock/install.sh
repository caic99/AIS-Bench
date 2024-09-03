#!/bin/bash
#Based on Docker container as the basic environment

# Download Uni-Doc Benchmarks on the host
cd ~
git clone https://github.com/dptech-corp/Uni-Dock-Benchmarks.git
cd Uni-Dock-Benchmarks/data/virtual_screening/GBA
wget https://bohrium-api.dp.tech/ds-dl/GBA-inactives-ap7r-v2.zip
apt install unzip -y
unzip  GBA-inactives-ap7r-v2.zip


#use the graphics card number 0 on the host
#to modify the corresponding container name and mapping path

docker run -d \
  --gpus "device=0" \
  --name molecular_docking \
  -it \
  -v /mnt/unidock/molecular_docking_results:/opt/Uni-Dock-Benchmarks/molecular_docking_results \
  registry.dp.tech/public/unidock_tools:1.1.2 \
  bash
  
