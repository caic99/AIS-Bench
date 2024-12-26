# Training
cd ../deepmd-kit/examples/water/dpa2
# Modify `numb_steps` in input[_torch].json for fast dev run;
# However, you'll (certainly) face trouble using a model trained with a small number of steps without convergence when running molecular dynamics with it.

dp --pt train input_torch_large.json

# Freezing
# ensure ./checkpoint is present
dp --pt freeze # generates `frozen_model.pth`
