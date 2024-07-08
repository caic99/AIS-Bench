# Inference
cd ../deepmd-kit/examples/water/lmp
# Modify `in.lammps`: At the line starting with `pair_style`, change model path to `../dpa2/frozen_model.pth`
# Optional: Change value of key "run" to 1 for fast dev run (the number of simulated steps)
ngpu=$(nvidia-smi --query-gpu=count --format=csv,noheader)
mpirun -n $ngpu lmp -in in.lammps
