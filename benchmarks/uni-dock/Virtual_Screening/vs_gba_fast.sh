#!/bin/bash
docker cp ~/Uni-Dock-Benchmarks vs_gba_fast:/opt
docker exec -it vs_gba_fast bash
cd /opt/Uni-Dock-Benchmarks
cat <<EOT > ./vs_gba_fast.json
{
    "rootdir": "./",
    "savedir": "vs_results_gba_fast",
    "search_mode_list": ["fast"],
    "dataset_names": ["GBA"]
}
EOT
nohup python scripts/test_virtual_screening.py --config_file vs_gba_fast.json &
