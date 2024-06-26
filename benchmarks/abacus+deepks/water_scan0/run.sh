#!/bin/bash -ex
if [ ! -d "water_scan0_test" ]; then
	wget -c https://hpc-profiling-example.oss-cn-beijing.aliyuncs.com/example/abacus/water_scan0_test.zip
	unzip water_scan0_test.zip
	cd water_scan0_test
	ln -sf INPUT_deepks INPUT
	cd ..
fi

cd water_scan0_test
source activate abacus
np=`nproc`
nt=1
OMP_NUM_THREADS=$nt mpirun -n $np abacus
# Ref: 2005s on 1t, 4p

cat OUT.ABACUS/running_scf.log | grep -i final_etot
## !FINAL_ETOT_IS -29927.1311197787763376 eV
cd -
