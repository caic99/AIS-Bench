conda create -n unimol pytorch torchvision torchaudio -c pytorch -c nvidia
conda activate unimol
# https://github.com/dptech-corp/Uni-Core#installation
pip install git+https://github.com/dptech-corp/Uni-Core.git

# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#dependencies
git clone https://github.com/dptech-corp/Uni-Mol.git
pip install ./Uni-Mol/unimol ./Uni-Mol/unimol_tools rdkit-pypi==2022.9.3

cd `python -c "import unimol_tools; print(unimol_tools.__path__[0])"`/weights
wget -c https://github.com/dptech-corp/Uni-Mol/releases/download/v0.1/mol_pre_all_h_220816.pt
