sudo sh -c "wget -O - https://dl.openfoam.org/gpg.key | apt-key add -"
sudo add-apt-repository http://dl.openfoam.org/ubuntu
sudo apt-get update
sudo apt-get -y install openfoam7

conda create -n deepflame python=3.8
conda activate deepflame
conda install -c cantera libcantera-devel
conda install pytorch torchvision torchaudio pytorch-cuda=11.6 -c pytorch -c nvidia
conda install pybind11
conda install -c conda-forge easydict

cd ~/miniconda3/envs/deepflame/lib
ln -s libmkl_rt.so.1 libmkl_rt.so.2
cd -

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