wget -c https://hpc-profiling-example.oss-cn-beijing.aliyuncs.com/example/abacus/water_scan0_test.zip
unzip water_scan0_test.zip
cd water_scan0_test
ln -sf INPUT_deepks INPUT

conda activate abacus
mpirun -n `nprocs` abacus # Ref: 486.57 s

cat OUT.ABACUS/running_scf.log | grep -i final_etot
## !FINAL_ETOT_IS -29927.1311197787763376 eV
