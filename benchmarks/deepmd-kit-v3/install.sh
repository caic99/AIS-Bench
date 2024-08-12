conda create -n dp3 deepmd-kit lammps -c conda-forge/label/deepmd-kit_dev -c conda-forge -y
# deepmd-kit-3.0.0a0|cuda120py311hb63a56f_mpi_mpich_0
conda activate dp3
git clone https://github.com/deepmodeling/deepmd-kit.git -b v3.0.0b3
