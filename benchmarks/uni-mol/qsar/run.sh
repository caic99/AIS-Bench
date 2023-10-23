mkdir datasets
wget -c https://dp-public.oss-cn-beijing.aliyuncs.com/community/hERG.csv -O datasets/hERG.csv
conda activate unimol
python3 run.py