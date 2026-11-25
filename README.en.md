# Claude Code experiment loop: a hands-on demo (about 15–20 minutes)

[中文](README.md)

Let Claude Code run "experiment → verify → adjust → next round" on its own until it meets a clear target.
Background: [Iterating experiments with Claude Code until a target is met: a workflow log](https://yenjia.github.io/posts/experiment-loop/).

Task: classify 28×28 breast ultrasound images as benign or malignant. The folder holds only data.
You give the rules in one prompt; Claude writes `CLAUDE.md`, the experiment log and the code itself.

## Setup

You need Python 3.10+ and Claude Code; CPU only. If numpy, scikit-learn and matplotlib are already installed, skip the environment step:

```bash
git clone https://github.com/yenjia/claude-loop-demo.git
cd claude-loop-demo
python3 -m venv .venv
.venv/bin/pip install -r requirements.txt     # Windows: .venv\Scripts\pip install -r requirements.txt
```

Without git, use Code → Download ZIP on the GitHub page.

## Start

```bash
cd claude-loop-demo
claude
```

Switching to auto mode (Shift+Tab) is recommended. Paste this prompt:

```text
This folder is a benign/malignant classification task on small breast ultrasound images; see data/README.md. First write the rules below into CLAUDE.md, then run the experiment loop until the target is met:

- Target: 5-fold CV AUC ≥ 0.80 on train, and val AUC ≥ 0.80. At most 6 rounds. If the target is not met, report the gap and the bottleneck honestly; do not tune on val to reach the number.
- The split is fixed: do not re-split or merge. Model selection and tuning use only CV on train; val is evaluated once per round, only for the configuration CV selected.
- Before the real experiments, run the pipeline once with shuffled labels to confirm there is no data leakage.
- Any result that meets the target must first pass a shortcut check: find where in the image the discriminative signal lies, and save the figures. If the signal is not on tissue, remove it and rerun; report both numbers. Only a clean result counts.
- Before writing each round to EXPERIMENTS.md, check the number of predictions and recompute AUC from the prediction files.
- Use only numpy, scikit-learn and matplotlib; install nothing else (use the python in .venv if it exists). CPU only; each experiment must finish within 2 minutes.
- Read and write only files inside this folder. Log each round in EXPERIMENTS.md: hypothesis, setup, CV, val, conclusion.
```

Then try not to intervene. Things to watch:

- How the `CLAUDE.md` it writes differs from your prompt
- What checks it runs before the real experiments
- Whether it stops the first time it "meets" the target
- Whether it meets the target in the end, and what `EXPERIMENTS.md` says for each round

## Afterwards

Look at `EXPERIMENTS.md` and the saved figures: did it meet the target? What problems did it catch along the way?
How the data was modified is described in the "Try it yourself" section of the post above (read it after your run).

Before handing it to the next person, run `./reset.sh` (on Windows, `git clean -fdx -e .venv`).
Only the data, docs, license and `.venv` are kept.

## License and sources

- Code and docs: MIT, see `LICENSE`.
- Data derived from BreastMNIST (MedMNIST v2, CC BY 4.0), re-split and modified for a teaching exercise. It is not a faithful copy of the original dataset and must not be used for research. Original sources:
  - Jiancheng Yang et al. "MedMNIST v2 – A large-scale lightweight benchmark for 2D and 3D biomedical image classification." *Scientific Data*, 2023.
  - Walid Al-Dhabyani et al. "Dataset of breast ultrasound images." *Data in Brief*, 2020.
