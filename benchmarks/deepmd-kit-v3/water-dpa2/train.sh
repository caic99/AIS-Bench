# Training
cd ../deepmd-kit/examples/water/dpa2
# modify `numb_steps` in input[_torch].json for fast dev run
dp --pt train input_torch.json # input_torch_large.json for 3.0.0b4

# Freezing
# ensure ./checkpoint is present
dp --pt freeze # generates `frozen_model.pth`
