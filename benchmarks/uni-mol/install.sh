
conda create -n unimol pytorch torchvision torchaudio -c pytorch
conda activate unimol
# https://github.com/dptech-corp/Uni-Core#installation
pip install git+https://github.com/dptech-corp/Uni-Core.git

# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#dependencies
git clone https://github.com/dptech-corp/Uni-Mol.git
pip install ./Uni-Mol
pip install rdkit-pypi==2022.9.3
pip install ./unimol_tools
wget -c https://github.com/dptech-corp/Uni-Mol/releases/download/v0.1/mol_pre_all_h_220816.pt -O ~/miniconda3/lib/python3.11/site-packages/unimol_tools/weights/mol_pre_all_h_220816.pt
