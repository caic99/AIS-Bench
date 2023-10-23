conda activate deepmd
cd ../deepmd-kit/examples/water/se_atten

# https://docs.deepmodeling.com/projects/deepmd/en/master/getting-started/freeze.html
dp freeze -o graph.pb
# DEEPMD INFO    1315 ops in the final graph.

dp test -m graph.pb -s ../data/data_0/ -n 1000000
# DEEPMD INFO    Adjust batch size from 2048 to 4096
# DEEPMD INFO    # number of test data : 30
# DEEPMD INFO    Energy RMSE        : 3.510479e-02 eV
# DEEPMD INFO    Energy RMSE/Natoms : 1.828375e-04 eV
# DEEPMD INFO    Force  RMSE        : 2.210830e-02 eV/A
# DEEPMD INFO    Virial RMSE        : 6.055581e+00 eV
# DEEPMD INFO    Virial RMSE/Natoms : 3.153949e-02 eV

# Criteria (This is a empirical & strict value; may change according to realistic data):
#     Energy RMSE/Natoms < 3.0e-4 eV
#     Force  RMSE        < 3.0e-2 eV/A
#     Virial RMSE/Natoms < 4.0e-2 eV
