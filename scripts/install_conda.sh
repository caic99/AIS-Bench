#!/bin/bash
wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
~/miniconda3/bin/conda init
source ~/.bashrc

# Recommended: set libmamba as the default solver
# https://www.anaconda.com/blog/conda-is-fast-now
conda install -n base conda-libmamba-solver
conda config --set solver libmamba
