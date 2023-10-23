# AIS-Bench: AI4S Benchmark Suite

## Background

- In AI4S, there are different scientific computing applications and neural network training/inference coupling; applications have their own storage/computing access requirements.
- Hardware platforms may have specific software/algorithm optimizations for applications.
- The results of scientific computing must be verifiable, reproducible, and consistent with the gold standard.

## Objective

- Compare the performance of typical AI4S computing applications on various hardware platforms.
- Ensure the reproducibility and correctness of the results.
- Guide the optimization of AI4S applications.

## Implementation

### Benchmark Suite

- Main applications: AI4S typical applications at different scales
  - DFT: ABACUS+DeePKS
  - MD: DeePMD-kit
  - CFD: DeepFlame
  - Molecular reprecentation: Uni-Mol

- Main scenarios: AI4S workflows have the following scenarios:
  - Labeling: Calling scientific computing software to generate labels for machine learning methods, serving as input data for neural networks.
  - Training: Using the generated labels to train the neural network.
  - Inference: Applying scientific computing software on a large scale, using trained models to replace/enhance the original algorithm, avoiding the computationally intensive part of traditional methods with fast model inference, achieving improved accuracy and speed; consider multi-machine scenarios.

- Test cases:
  - Selection criteria: Representativeness and a certain amount of computation.

### Result visualizaion
