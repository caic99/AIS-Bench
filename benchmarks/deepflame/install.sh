# https://deepflame.deepmodeling.com/en/latest/qs/install.html

# OpenFOAM-7
# Installing from RPM: https://openfoam.org/news/ubuntu-20-04-lts/
# sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key | apt-key add -"
# sudo add-apt-repository http://dl.openfoam.org/ubuntu
# sudo apt-get update
# sudo apt-get -y install openfoam7

# OR, compile from source: https://openfoam.org/download/7-source/
# Ref: https://openfoam.org/download/source/
gcc --version
sudo apt-get install build-essential cmake git ca-certificates
sudo apt-get install flex libfl-dev bison zlib1g-dev libboost-system-dev libboost-thread-dev libopenmpi-dev openmpi-bin gnuplot libreadline-dev libncurses-dev libxt-dev

# git clone https://github.com/OpenFOAM/OpenFOAM-dev.git
# git clone https://github.com/OpenFOAM/ThirdParty-dev.git
cd /tmp # Or building in-place: cd ~
wget -O - http://dl.openfoam.org/source/7 | tar xz
wget -O - http://dl.openfoam.org/third-party/7 | tar xz
mv OpenFOAM-7-version-7 OpenFOAM-7
mv ThirdParty-7-version-7 ThirdParty-7
source OpenFOAM-7/etc/bashrc
./OpenFOAM-7/Allwmake -j # Takes ~1h on 8 cores
OF_INSTALL_DIR=/opt
sudo mv OpenFOAM-7 ThirdParty-7 $OF_INSTALL_DIR # Optional

# Cantera and PyTorch
conda create -n deepflame \
	pytorch torchvision torchaudio libcantera-devel easydict pybind11 pkg-config \
	-c pytorch -c nvidia -c cantera -c conda-forge

source activate deepflame

# may not required
cd $CONDA_PREFIX/lib
ln -s libmkl_rt.so.1 libmkl_rt.so.2
cd -

# DeepFlame
git clone https://github.com/deepmodeling/deepflame-dev.git
cd deepflame-dev
# Allwclean may be required on update
source $OF_INSTALL_DIR/OpenFOAM-7/etc/bashrc
. configure.sh --use_pytorch
source ./bashrc
. install.sh

git clone https://github.com/deepcombustion/deepcombustion.git
cp -r deepcombustion/DeePCK/Model/HE04_Hydrogen_ESH2_GMS_sub_20221101/ mechanisms/

cd -
