# Data

Breast ultrasound images, downsampled to 28×28 grayscale (uint8).

| File | Images | Malignant |
| --- | ---: | ---: |
| `train.npz` | 468 | 27% |
| `val.npz` | 156 | 27% |

Each file has `images` (N, 28, 28) uint8, `labels` (N,) with 1 = malignant, `ids` (N,) str.

Derived from BreastMNIST (MedMNIST v2, CC BY 4.0), re-split and modified for a teaching
exercise. It is not a faithful copy of the original dataset and must not be used for research.
