source activate deepflame
source /opt/OpenFOAM-7/etc/bashrc
source ../deepflame-dev/bashrc

# https://deepflame.deepmodeling.com/en/latest/qs/examples.html
cd ../deepflame-dev/examples/dfLowMachFoam/threeD_reactingTGV/H2/pytorchIntegrator
./Allclean
# Execute
./Allrun
# Currently some errors are thrown in the finalize stage;
# This does not affect the generated result.

# Verify
realpath log.mpirun
cat log.mpirun | grep 'max(T)' | grep -o -E '\-?[0-9\.]+' | tee result.txt
# Last line:
# min/max(T) = 300.932, 1495.56

# For the same setup, the result should be exactly same (EXPECT_DOUBLE_EQ);
# If different NN inference backend is used, the number should be within a variation of 1.
# TODO: Plotting with CVODE: https://deepflame.deepmodeling.com/en/latest/qs/examples.html#deepflame-with-dnn
cd -
