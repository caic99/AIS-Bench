#!/bin/bash
docker cp ~/Uni-Dock-Benchmarks vs_no_gba:/opt
docker exec  -it vs_no_gba bash
cd /opt/Uni-Dock-Benchmarks
cat <<EOT > ./vs_no_gba.json
{
    "rootdir": "./",
    "savedir": "vs_results_no_gba",
    "search_mode_list": ["fast", "balance", "detail"],
    "dataset_names": ["D4", "NSP3", "PPARG", "sigma2"]
}
EOT
nohup python scripts/test_virtual_screening.py --config_file vs_no_gba.json &
