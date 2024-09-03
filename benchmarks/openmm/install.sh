#!/bin/bash
#download  examples from https://github.com/openmm/openmm/tree/master/examples
docker run -d  \
  --gpus "device=0"  \
  --name openmm-benchmark  \
  -it  \
  -v /mnt/openmm-benchmark:/openmm-benchmark  \
  registry.dp.tech/dplc/hfep:v0.6.2.5-decrypt-public-cuda10.1 \
  bash
  
docker cp examples openmm-benchmark:/openmm-benchmark 
docker exec -it openmm-benchmark bash
cd /openmm-benchmark
conda install openmm -c conda-forge
cd examples
nohup python benchmark.py --platform=CUDA --style=table --outfile=benchmark.json &
