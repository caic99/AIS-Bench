## Instructions

### Running the benchmarks

The benchmark suite consists of three steps:

1. Training a DP model: `dp --pt train input.json`
This step uses the high-accuracy dataset to train a neural network, predicting the potential energy of a system of atoms.

2. Freezing the model: `dp --pt freeze`
This step freezes the model, saving it to a file ready for further use.

3. Testing the model: `dp --pt test -m frozen_model.pth`
This step uses the frozen model to make predictions on a test set of data, and evaluates the accuracy of the model.

4. Running molecular dynamics simulations: `lmp -in in.lammps`
This step uses the frozen model to run an molecule simulation task.
**It requires [the C++ interface](https://docs.deepmodeling.com/projects/deepmd/en/master/install/install-from-source.html#install-the-c-interface) of deepmd-kit to be installed.**

Of the four steps above, the weightlifting step is the first one (`train.sh`) and the last one (`run_md.sh`), which we mainly focus on. The test step is solely for the purpose of verifying the correctness of the trained model.

### Choosing a version

DeePMD-kit v2 only uses TensorFlow as the backend, while DeePMD-kit v3 supports both TensorFlow and PyTorch. The benchmark suite provides scripts for both versions.
We recommend using DeePMD-kit v3 with PyTorch backend, as it supports the latest DPA-series models, and the PyTorch backend support is more easier to build.

### Installing DeePMD-kit

One can install DeePMD-kit by following the instructions in the [official documentation](https://docs.deepmodeling.com/projects/deepmd/en/master/install/index.html).
The official channel provides buildings for CPU and CUDA, supporting running molecule dynamics. For other platforms, it is possible to build from source.
Here is a sample script for building DeePMD-kit from source:

```bash
cd deepmd-kit
SKBUILD_LOGGING_LEVEL=DEBUG DP_VARIANT=rocm DP_ENABLE_TENSORFLOW=1 DP_ENABLE_PYTORCH=1 TORCH_CUDA_ARCH_LIST=8.0 CMAKE_ARGS="-DLAMMPS_SOURCE_ROOT=~/lammps -DBUILD_CPP_IF=1 -DTORCH_CUDA_ARCH_LIST=8.0" CC=gcc CXX=g++ pip install . -vvv
```

The variables and requirements should be configured according to the specific environment following [the instructions](https://docs.deepmodeling.com/projects/deepmd/en/master/install/install-from-source.html#install-the-deepmd-kit-s-python-interface).
