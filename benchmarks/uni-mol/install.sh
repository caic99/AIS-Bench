conda create -n unimol pytorch torchvision torchaudio -c pytorch -c nvidia
source activate unimol

# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#dependencies
# https://github.com/dptech-corp/Uni-Core#installation
# Building wheel for unicore may take minutes
pip install \
	git+https://github.com/dptech-corp/Uni-Core.git \
	git+https://github.com/dptech-corp/Uni-Mol.git#subdirectory=unimol \
	git+https://github.com/dptech-corp/Uni-Mol.git#subdirectory=unimol_tools \
	rdkit-pypi==2022.9.3

wget -c https://github.com/dptech-corp/Uni-Mol/releases/download/v0.1/mol_pre_all_h_220816.pt \
	-P `python -c "import unimol_tools; print(unimol_tools.__path__[0])"`/weights
