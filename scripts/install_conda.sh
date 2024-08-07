#!/bin/bash -ex
which wget || apt update && apt install -y wget
wget -c https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
export PATH=~/miniconda3/bin:$PATH
conda init
source ~/.bashrc

# Recommended: set libmamba as the default solver
# https://www.anaconda.com/blog/conda-is-fast-now
conda install -n base conda-libmamba-solver -y
conda config --set solver libmamba
