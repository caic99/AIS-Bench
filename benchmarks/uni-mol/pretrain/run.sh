# Download training data (115G)
# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#uni-mols-3d-conformation-data
wget -c https://bioos-hermite-beijing.tos-cn-beijing.volces.com/unimol_data/pretrain/ligands.tar.gz
test -d ligands || tar xf ligands.tar.gz
# For performance evaluation, the validation set (~0.8G) can be downloaded from
# https://www.aissquare.com/datasets/detail?pageType=datasets&name=Uni-Mol-Pretrain-Valid&id=290
# wget -c https://store.aissquare.com/datasets/8021519d-e706-40c7-a770-03eda2891c5b/valid.lmdb

# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#molecular-pretraining
source activate unimol

data_path=./ligands # replace to your data path
save_dir=./save # replace to your save path
n_gpu=1
MASTER_PORT=10086
lr=1e-4
wd=1e-4
batch_size=128
update_freq=1
masked_token_loss=1
masked_coord_loss=5
masked_dist_loss=10
x_norm_loss=0.01
delta_pair_repr_norm_loss=0.01
mask_prob=0.15
only_polar=0
noise_type="uniform"
noise=1.0
seed=1
warmup_steps=10000
max_steps=1000000

export NCCL_ASYNC_ERROR_HANDLING=1
export OMP_NUM_THREADS=4
torchrun --nproc_per_node=$n_gpu --master_port=$MASTER_PORT $(which unicore-train) $data_path  --user-dir ./unimol --train-subset train --valid-subset valid \
       --num-workers 8 --ddp-backend=c10d \
       --task unimol --loss unimol --arch unimol_base  \
       --optimizer adam --adam-betas "(0.9, 0.99)" --adam-eps 1e-6 --clip-norm 1.0 --weight-decay $wd \
       --lr-scheduler polynomial_decay --lr $lr --warmup-updates $warmup_steps --total-num-update $max_steps \
       --update-freq $update_freq --seed $seed \
       --fp16 --fp16-init-scale 4 --fp16-scale-window 256 --tensorboard-logdir $save_dir/tsb \
       --max-update $max_steps --log-interval 10 --log-format simple \
       --save-interval-updates 10000 --validate-interval-updates 10000 --keep-interval-updates 10 --no-epoch-checkpoints  \
       --masked-token-loss $masked_token_loss --masked-coord-loss $masked_coord_loss --masked-dist-loss $masked_dist_loss \
       --x-norm-loss $x_norm_loss --delta-pair-repr-norm-loss $delta_pair_repr_norm_loss \
       --mask-prob $mask_prob --noise-type $noise_type --noise $noise --batch-size $batch_size \
       --save-dir $save_dir  --only-polar $only_polar
