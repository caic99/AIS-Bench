# import lbgcore.client, lbgcore.jobgroup, lbgcore.job

# client = lbgcore.client.Client(
#     email="caic@bjaisi.com", token="54c18ad4bdfb4577bfa047334d29c466"
# )
# jobgroup = lbgcore.jobgroup.JobGroup(client)
# jobgroup_id = jobgroup.create(project_id=24019, name="test")["projectId"]

import os
import json
from copy import deepcopy

gpu_machine_types = (
    "c12_m64_1 * NVIDIA L4",
    "1 * NVIDIA P100_16g",
    "1 * NVIDIA T4_16g",
    "1 * NVIDIA V100_32g",
    "c6_m64_1 * NVIDIA 3090",
    "1 * NVIDIA 4090_24g",
    "1 * NVIDIA L20_48g",
)
cpu_machine_types = (
    "c8_m32_cpu",
    "c16_m64_cpu",
    "c32_m128_cpu",
    "c48_m256_cpu",
    "c64_m256_cpu",
    # "c96_m352_cpu",
    # "c128_m512_cpu",
) # Bohrium CPU instances does not have a static backend service;
# thus, the results can not be considered as a fair comparison.

job_config_template = {
    ##"job_name": f"{machine_type}",
    ##"machine_type": machine_type,

    ### "command": command, # instantiated in template
    # "log_file": "se_e2_a/tmp_log",
    # "out_files": ["se_e2_a/lcurve.out", "se_e2_a/graph.pb"], # by default get STDOUTERR
    # "platform": "ali",
    # "disk_size": 200,
    # "input_file_path": "./",
    "image_address": "registry.dp.tech/dptech/prod-375/bench:v2",
    "image_name": "registry.dp.tech/dptech/prod-375/bench:v2",
    # "job_group_id": jobgroup_id,
    "project_id": 24019,
    # "result_path": f"/personal/bench/{machine_type.replace(' ', '_')}",
}

dp_job_config = deepcopy(job_config_template)
dp_job_config={
    "name":"deepmd-kit_water-se_atten",
    "command":r"""
source /root/miniconda3/bin/activate dp3
wd=`pwd`
cd ~/AIS-Bench/benchmarks/deepmd-kit-v3/water-dpa2
cd ../deepmd-kit/examples/water/se_atten
dp --pt train $wd/input.json
""",
    "input_file_path":"~/AIS-Bench/benchmarks/deepmd-kit-v2/deepmd-kit/examples/water/se_atten"#/input.json",
}

abacus_job_config = {
    "name":"abacus-battery",
    "command":r"""
source /root/miniconda3/bin/activate abacus
cd ~
# wget --no-proxy https://dp-public.oss-cn-beijing.aliyuncs.com/k8s/speedUp.sh -O speedUp.sh && bash speedUp.sh >> start.log
# git clone https://github.com/deepmodeling-activity/abacus-test.github.io.git --depth 1
# dir=/root/abacus-test.github.io/datasets/dataset1-pw/006_27Fe
dir=/root/abacus-test.github.io/datasets/dataset2-lcao/004_Li128C75H100O75
### echo "device gpu" >> INPUT # CHANGE INPUT FILES!
cd $dir
cp -r . /tmp
cd /tmp
abacus
""",
    "input_file_path":"~/cc/abacus-test.github.io/datasets/dataset2-lcao/004_Li128C75H100O75"#/INPUT"
}
test_job_config={
    "name":"test",
    "command": r"pwd",
}

# Select a config !!!
job_config = abacus_job_config
job_config.update(job_config_template)
machine_types = gpu_machine_types
# machine_types = gpu_machine_types[2:4]

# create an access key at https://bohrium.dp.tech/settings/user
os.environ["ACCESS_KEY"] = "my_access_key"

output = os.popen(
    f"lbg jobgroup create -p 24019 -n {job_config['name']}"
).read()  # {'groupId': 4192911}
# extract jobgroup_id
jobgroup_id = json.loads(output.replace("'", '"'))["groupId"]
print(f"{jobgroup_id=}")
print(f"https://bohrium.dp.tech/jobs/list?id={jobgroup_id}")
print()
job_config["job_group_id"] = jobgroup_id

job_ids=[]
for machine_type in machine_types:
    print(f"{machine_type=}")
    job_config["job_name"] = f"{machine_type}"
    job_config["machine_type"] = machine_type
    job_config["result_path"] = (
        f"/personal/bench/{jobgroup_id}_{job_config['name']}/{machine_type.replace(' ', '_')}"
    )

    with open("job.json", "w") as f:
        json.dump(job_config, f)

    output = os.popen(
        f'bohr job submit -i job.json --input_file_path {job_config["input_file_path"]} --result_path {job_config["result_path"]}'
    ).read()
    print(output.strip())
    # Submit job succeed.
    # JobId: 14557609
    # JobGroupId: 13324684

    # Get JobId from output
    if output.split("\n")[0].strip()=="Submit job succeed.":
        job_id = int(output.split("\n")[1].split(":")[1].strip())
        job_ids.append(job_id)
        print(f"https://bohrium.dp.tech/jobs/detail/{job_id}")
    print()
print(f"{job_ids=}")

# grep -r "average training time" .
# grep -r "TOTAL  Time" .
