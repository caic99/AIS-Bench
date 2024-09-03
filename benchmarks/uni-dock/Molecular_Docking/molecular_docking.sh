#!/bin/bash
cd ~
docker cp Uni-Dock-Benchmarks molecular_docking:/opt

docker exec -it molecular_docking bash
cd /opt/Uni-Dock-Benchmarks
cat <<EOT > ./molecular_docking.json
{
    "rootdir": "./",
    "savedir": "molecular_docking_results",
    "round": 1
}
EOT
nohup python scripts/test_molecular_docking.py --config_file molecular_docking.json &
