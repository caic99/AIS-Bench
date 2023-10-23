conda activate deepmd

cd ../deepmd-kit/examples/water/lmp
ln -s ../se_atten/graph.pb frozen_model.pb
ngpu=${nvidia-smi --query-gpu=count --format=csv,noheader}

mpirun -n $ngpu lmp -in in.lammps # lmp_mpi

# Total wall time: 0:00:14
#    Step         PotEng         KinEng         TotEng          Temp          Press          Volume
#       1000  -29944.53       8.5122441     -29936.018      344.78317     -976.14341      1927.3176