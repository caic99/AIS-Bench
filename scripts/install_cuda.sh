#!/bin/bash

# https://developer.nvidia.com/cuda-downloads
# Install CUDA for ubuntu 22.04
# mirror: https://mirrors.aliyun.com/nvidia-cuda/ubuntu2204
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.0-1_all.deb
sudo dpkg -i cuda-keyring_1.0-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda
