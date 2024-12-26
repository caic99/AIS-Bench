# ABACUS benchmark

## Usage

### Environment

Please refer to [the guide on installing ABACUS](https://abacus.deepmodeling.com/en/latest/quick_start/easy_install.html).
We recommend starting from the Docker image built with Intel OneAPI for the best performance: `registry.dp.tech/deepmodeling/abacus-intel`. Please use `abacus-cuda` for NVIDIA GPUs. If you encounter compatibility issues, `abacus-gnu` is also available.
Installing from conda repo and from source are also available, and please check the docs for details.

### Run the test cases

Each test case is a folder containing `INPUT` file and other necessary files. The test cases are run by the following command:

```bash
cd 000_4GaAs
OMP_NUM_THREADS=4 mpirun -n 8 abacus
```

Here, 4 and 8 are the number of OpenMP threads (nt) and MPI processes (np), respectively.
We recommend setting nt*np to the number of CPU physical cores on your machine.
For `pw` basis set, `nt=1` would be the best choice; and for `lcao` basis set, setting `nt` to a value no larger than 8 would generally deliver the best performance.
It is possible to tune these parameters for highest possible performance.

### Running on GPU

Input files should be [modified](https://abacus.deepmodeling.com/en/latest/advanced/acceleration/cuda.html#run-with-the-gpu-support-by-editing-the-input-script) by adding `device gpu` to the `INPUT` file, and setting `ks_solver cusolver` for `lcao` basis set and `ks_solver dav` for `pw` basis set.
The number of MPI processes (np) should be set to the number of GPUs on the machine.

## Test cases

- `lcao` and `pw` are the two basis set used for ABACUS. The test cases are run for both the basis sets.
  - For `lcao` basis, we recommend using `ks_solver genelpa`  with `np=4/8` for the best performance.
  - For `pw` basis on CPU, we recommend using `ks_solver dav` with `nt=1` for the best performance.
  - Please refer to the docs on [choosing a solver](https://abacus.deepmodeling.com/en/latest/advanced/input_files/input-main.html#ks-solver) for the best performance.
- `water_scan0` is the test set for using the function of [DeePKS](https://abacus.deepmodeling.com/en/latest/advanced/interface/deepks.html), an AI-assisted DFT calculation model.

The test cases are stored at <https://github.com/deepmodeling-activity/abacus-test.github.io.git>/datasets/{dataset1-pw, dataset2-lcao}.

### Result

We offer the reference results for two representative test cases, `dataset1-pw/006_27Fe` and `dataset2-lcao/004_Li128C75H100O75`.
The visualized results are available at <https://deepmodeling.com/space/ABACUS/benchmark>.
