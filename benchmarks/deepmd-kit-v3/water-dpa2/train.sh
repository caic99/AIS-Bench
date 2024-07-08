# Training
cd ../deepmd-kit/examples/water/dpa2
# modify `numb_steps` in input[_torch].json for fast dev run
dp --pt train input_torch.json

# Freezing
# ensure ./checkpoint is present
dp --pt freeze # generates `frozen_model.pth`
