# ABACUS benchmark

## Test cases

- `lcao` and `pw` are the two basis set used for ABACUS. The test cases are run for both the basis sets.
- `water_scan0` is the test set for using the function of [DeePKS](https://abacus.deepmodeling.com/en/latest/advanced/interface/deepks.html), an AI-assisted DFT calculation model.

The test cases are stored at <https://github.com/deepmodeling-activity/abacus-test.github.io.git>/datasets/{dataset1-pw, dataset2-lcao}.

## Usage

### Environment

Please refer to [the guide on installing ABACUS](https://abacus.deepmodeling.com/en/latest/quick_start/easy_install.html). We recommend starting from the Docker image built with Intel OneAPI for the best performance: `registry.dp.tech/deepmodeling/abacus-intel`. Installing from conda repo and from source are also available, and please check the docs for details. Please use `abacus-cuda` for NVIDIA GPUs.

### Run the test cases

Each test case is a folder containing `INPUT` file and other necessary files. The test cases are run by the following command:

```bash
cd 000_4GaAs
OMP_NUM_THREADS=4 mpirun -n 8 abacus
```

Here, 4 and 8 are the number of OpenMP threads (nt) and MPI processes (np), respectively.
We recommend setting nt*np to the number of CPU physical cores on your machine.
For `pw` basis set, `nt=1` would be the best choice; and for `lcao` basis set, setting `nt` to a value no larger than 8 would generally deliver the best performance.
It is possible to tune these parameters.

### Running on GPU

Input files should be [modified](https://abacus.deepmodeling.com/en/latest/advanced/acceleration/cuda.html#run-with-the-gpu-support-by-editing-the-input-script) by appending `device gpu` to `INPUT`.
The number of MPI processes (np) should be set to the number of GPUs on the machine.

### Result

We offer the reference results for two representative test cases, `dataset1-pw/006_27Fe` and `dataset2-lcao/004_Li128C75H100O75`.
The visualized results are available at <https://deepmodeling.com/space/ABACUS/benchmark>.
