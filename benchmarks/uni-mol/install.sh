conda create -n unimol pytorch torchvision torchaudio -c pytorch -c nvidia
source activate unimol

# https://github.com/dptech-corp/Uni-Mol/tree/main/unimol#dependencies
# https://github.com/dptech-corp/Uni-Core#installation
# Building wheel for unicore may take minutes
pip install \
	git+https://github.com/dptech-corp/Uni-Core.git \
	git+https://github.com/dptech-corp/Uni-Mol.git#subdirectory=unimol \
	git+https://github.com/dptech-corp/Uni-Mol.git#subdirectory=unimol_tools \
	rdkit==2023.9.1  # The latest RDKit might has errors on loading training data

wget -c https://github.com/dptech-corp/Uni-Mol/releases/download/v0.1/mol_pre_all_h_220816.pt \
	-P `python -c "import unimol_tools; print(unimol_tools.__path__[0])"`/weights
