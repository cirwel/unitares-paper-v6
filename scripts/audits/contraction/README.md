# Continuous and numerical contraction checks

These offline checks accompany v6.9.4. They reproduce
mathematical arithmetic and source-level counterexamples, without a running
UNITARES server, database, outcome data or trial statistics.

Python 3 and NumPy are required for `continuous.py` and `discrete.py`.
`extensions.py` uses only the Python standard library. Run without `python -O`,
which would disable the assertions.

```bash
python continuous.py
python extensions.py
python discrete.py --repo /path/to/local/unitares
```

Each command prints JSON and asserts its core checks. The commands assume this
directory as the working directory; they also work with explicit script paths.

- `continuous.py`: exact rational row bounds establishing the conditional 0.019
  certificate, a floating-point normalized symmetric-matrix vertex check, and a
  counterexample to the former incomplete sufficient condition. Its historical
  `source_head` identifies the draft audited before these corrections.
- `extensions.py`: closed-form OU, RMS, network, logistic and projected Euler
  examples identifying defects in that historical draft. Source line numbers
  refer to the pinned historical revision, not the corrected manuscript.
- `discrete.py`: exports five modules from UNITARES commit
  `6d742273434c6cc8a7cfa10ea4e29e969660e719` into a disposable directory and
  records their SHA-256 hashes. The `--repo` clone must contain this Git object.
  It bypasses package startup, pins relevant environment switches, and does not
  import the clone's working files or alter its checkout. Temporary exported
  files are removed when the process exits.

The finite-step example establishes expansion of one pair under the pinned
map. It does not establish normal-operation reachability, frequency, long-run
instability or predictive usefulness. A later numerical fix does not change the
historical counterexample; it requires separate validation against its own source.
