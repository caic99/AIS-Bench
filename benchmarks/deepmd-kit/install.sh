# https://docs.deepmodeling.com/projects/deepmd/en/master/getting-started/install.html#install-with-conda
conda create -n deepmd deepmd-kit=*=*gpu libdeepmd=*=*gpu lammps cudatoolkit=11.6 horovod -c https://conda.deepmodeling.com -c defaults
git clone https://github.com/deepmodeling/deepmd-kit.git
