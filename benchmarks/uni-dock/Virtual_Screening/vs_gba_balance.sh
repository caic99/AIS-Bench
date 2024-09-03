#!/bin/bash
docker cp ~/Uni-Dock-Benchmarks vs_gba_balance:/opt
docker exec -it vs_gba_balance bash
cd /opt/Uni-Dock-Benchmarks
cat <<EOT > ./vs_gba_balance.json
{
    "rootdir": "./",
    "savedir": "vs_results_gba_balance",
    "search_mode_list": ["balance"],
    "dataset_names": ["GBA"]
}
EOT
nohup python scripts/test_virtual_screening.py --config_file vs_gba_balance.json &
