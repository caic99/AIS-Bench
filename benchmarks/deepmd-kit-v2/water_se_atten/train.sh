source activate deepmd
cd ../deepmd-kit/examples/water/se_atten

# TODO: Select a certain batch*step
# https://docs.deepmodeling.com/projects/deepmd/en/master/train/parallel-training.html#how-to-use
ngpu=$(nvidia-smi --query-gpu=count --format=csv,noheader)
horovodrun -np $ngpu dp train --mpi-log=workers input.json
# dp train input.json
# DEEPMD rank:0  INFO    wall time: 73350.656 s
# average training time: 0.0719 s/batch (exclude first 100 batches)
