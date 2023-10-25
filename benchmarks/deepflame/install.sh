# https://deepflame.deepmodeling.com/en/latest/qs/install.html

# OpenFOAM-7
# Requires Ubuntu 20
sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key | apt-key add -"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt-get update
sudo apt-get -y install openfoam7

# Cantera and PyTorch
conda create -n deepflame \
	pytorch torchvision torchaudio libcantera-devel easydict pybind11 \
	-c pytorch -c nvidia  -c cantera  -c conda-forge

conda activate deepflame

# may not required
cd $CONDA_PREFIX/lib
ln -s libmkl_rt.so.1 libmkl_rt.so.2
cd -

# DeepFlame
git clone https://github.com/deepmodeling/deepflame-dev.git
cd deepflame-dev
# Allwclean may be required on update
source /opt/openfoam7/etc/bashrc
. configure.sh --use_pytorch
source ./bashrc
. install.sh

git clone https://github.com/deepcombustion/deepcombustion.git
cp -r deepcombustion/DeePCK/Model/HE04_Hydrogen_ESH2_GMS_sub_20221101/ mechanisms/

cd -
