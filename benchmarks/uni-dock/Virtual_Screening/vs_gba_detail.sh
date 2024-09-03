#!/bin/bash
docker cp ~/Uni-Dock-Benchmarks vs_gba_detail:/opt
docker exec -it vs_gba_detail bash
cd /opt/Uni-Dock-Benchmarks
cat <<EOT > ./vs_gba_detail.json
{
    "rootdir": "./",
    "savedir": "vs_results_gba_detail",
    "search_mode_list": ["detail"],
    "dataset_names": ["GBA"]
}
EOT
nohup python scripts/test_virtual_screening.py --config_file vs_gba_detail.json &
