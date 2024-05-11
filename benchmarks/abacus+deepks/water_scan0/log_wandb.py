import wandb
import os
from pathlib import Path
import subprocess
run=wandb.init(project="bench", entity="caic", name="abacus+deepks/water_scan0")
assert run is not None

# test_case_dir="abacus-develop/tests/performance/P002_si64_pw"
test_case_dir=Path("./water_scan0_test")
os.chdir(test_case_dir)
workload=subprocess.run("OMP_NUM_THREADS=1 mpirun -n 4 abacus", capture_output=True, text=True, shell=True)
workload.check_returncode()
print(workload.stdout)
for line in workload.stdout.split("\n"):
	if any(' '+algo in line for algo in ["CG", "DA", "GE", "GV"]):
		# ITER   ETOT(eV)       EDIFF(eV)      DRHO       TIME(s)
		#  CG1    -3.435807e+03  0.000000e+00   3.607e-01  1.352e-02
		# log those fields to wandb
		fields = line.split()
		log={}
		it = int(fields[0][2:])
		log["ETOT"] = float(fields[1])
		log["EDIFF"] = float(fields[2])
		log["DRHO"] = float(fields[3])
		log["TIME"] = float(fields[4])
		run.log(log, step=it, commit=False)

# extract final energy
with open(test_case_dir / "OUT.autotest/running_scf.log") as f:
	for line in f:
		if "FINAL_ETOT_IS" in line:
			# !FINAL_ETOT_IS -29927.1311197787763376 eV
			etot = float(line.split()[-2])
			run.summary["ETOT"] = etot
			print("ETOT", run.summary["ETOT"])
			test_case_name = os.path.basename(test_case_dir)
			if test_case_name == "water_scan0_test":
				assert abs(etot - -29927.1311197787763376) < 1
			break

wandb.finish()
