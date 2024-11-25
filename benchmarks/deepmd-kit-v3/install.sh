conda create -n dp3 deepmd-kit=3 lammps -c conda-forge -y
# conda-forge/linux-64::deepmd-kit-3.0.0-cuda120py312he7ec23b_mpi_mpich_0
conda activate dp3
git clone https://github.com/deepmodeling/deepmd-kit.git -b v3.0.0
