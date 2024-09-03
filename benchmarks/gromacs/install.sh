#!/bin/bash
#Gromacs 自由能计算测速
#单个模拟测速：
docker run -d \
--gpus "device=1"  \
--name GROMACS_free_energy_fep  \
-v /mnt/gromacs/fep:/fep \
registry.dp.tech/dplc/hfep:v0.6.2.5.update3-decrypt-public-cuda10.1  \
/bin/bash -c "cp -r /gmx_testcase /fep &&  \
cd /fep/gmx_testcase &&  \
nohup bash run_fep.sh & sleep infinity"


#Replica Exchange测速
docker run -d \
--gpus "device=1"  \
--name GROMACS_free_energy_mpi_fep  \
-v /mnt/gromacs/mpi_fep:/mpi_fep \
registry.dp.tech/dplc/hfep:v0.6.2.5.update3-decrypt-public-cuda10.1  \
/bin/bash -c "cp -r /gmx_testcase /mpi_fep &&  \
cd /mpi_fep/gmx_testcase/gmx_fep_production &&  \
nohup bash run_mpi_fep.sh & sleep infinity"


#To improve performance, Replica Exchange speed measurement can enable Nvidia MPS
# 启动 MPS 服务
nvidia-cuda-mps-control  -d

docker run -d \
  --gpus "device=0"  --ipc=host  \
  --name  mps_GROMACS_free_energy_fep \
  -it  \
  -v /mnt/mps_gromacs/fep:/fep \
  registry.dp.tech/dplc/hfep:v0.6.2.5-decrypt-public-cuda10.1 \
  bash -c "mkdir -p /tmp/nvidia-mps;  \
  export CUDA_MPS_PIPE_DIRECTORY=/tmp/nvidia-mps;  \
  export CUDA_VISIBLE_DEVICES=0; \
  export CUDA_MPS_ACTIVE_THREAD_PERCENTAGE=50; \
  bash"

# 以上设置每个进程的 GPU 计算资源百分比为 50%
