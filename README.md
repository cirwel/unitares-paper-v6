# UNITARES v6

**Information-Theoretic Governance of Heterogeneous Agent Fleets**

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.19647159.svg)](https://doi.org/10.5281/zenodo.19647159)
[![License: CC BY 4.0](https://img.shields.io/badge/License-CC_BY_4.0-lightgrey.svg)](https://creativecommons.org/licenses/by/4.0/)
[![Latest published: paper-v6.9.4](https://img.shields.io/badge/latest-paper--v6.9.4-brightgreen.svg)](https://github.com/CIRWEL/unitares-paper-v6/releases/latest)

- 📄 [`unitares-v6.pdf`](./unitares-v6.pdf) — the paper (v6.9.4, published October 13, 2026; [version DOI](https://doi.org/10.5281/zenodo.23337711), tag [`paper-v6.9.4`](https://github.com/CIRWEL/unitares-paper-v6/releases/tag/paper-v6.9.4))
- 📝 [`unitares-v6.tex`](./unitares-v6.tex) — LaTeX source
- 🖼 [`figures/`](./figures/) — 6 figures from deployment data (Feb 20, 2026 snapshot; Apr 18, 2026 30-day window)
- 🗒 [Release history](https://github.com/CIRWEL/unitares-paper-v6/releases) — per-version notes and frozen PDFs

---

**In one line:** UNITARES updates a state estimate at each agent check-in, computes drift indicators, and records governance interventions. This paper describes the February–April 2026 deployment evidence.

---

## What the paper argues

This paper describes the dated deployment and migration studied in its February–April 2026 evidence. Its information-theoretic definitions are research targets. For the current implementation and decision path, consult [UNITARES's EISV computation contract](https://github.com/CIRWEL/unitares/blob/master/docs/EISV_COMPUTATION.md); the paper is not the live specification.

**Claim status (added October 16, 2026; the paper text is unchanged).** UNITARES now reads EISV as a runtime state estimate: digital proprioception senses, EISV estimates state, autonomic governance regulates. Read the paper's free-energy material at that level. The Free-Energy-Principle frame in §4 (*Choice of Frame*) and the *grounded interpretation* remark on the coupling structure are research interpretation. The conclusion's phrase "monitors free-energy proxies" means the deployed tier-3 heuristic estimators that the paper interprets against free-energy targets; no deployed quantity has been shown to track variational free energy. The canonical wording is UNITARES's [EISV proprioception contract](https://github.com/CIRWEL/unitares/blob/master/docs/ontology/eisv-proprioception-contract.md).

Governance of autonomous AI agents is usually assembled from output filters, dashboards, and post-hoc evaluators — each operating on a population the designer imagined as roughly homogeneous. UNITARES argues that this assumption fails once a real fleet is heterogeneous: embodied agents with sensor-driven state, persistent autonomous services, session-bounded coding assistants, and ephemeral parser agents do not share an output modality, a tempo, or a healthy operating point. Fleet-wide normalization is then the wrong target, and a governance framework that collapses the population to a single distribution — what we call *cosmological soup* — loses signal exactly where signal matters.

The paper makes two structural moves:

1. **Information-theoretic target semantics for the EISV state vector** (the deployed system computes all four coordinates with tier-3 heuristic estimators; the higher tiers are specified, not implemented) — `S` as Shannon entropy of the response distribution, `I` as mutual information between context and response, `E` as negative variational free energy, `V` as accumulated free-energy residual. Each coordinate ships with a tiered computation recipe (logprob, multi-sample, heuristic) and a provenance-tagged scale constant.

2. **Class-conditional calibration** — scale constants and healthy operating points are functions of an agent class, keyed on existing identity tags, with fleet-wide defaults retained only as fallback. Phase 2 measurement on five production classes (Lumen, Sentinel, Vigil, Watcher, default) over a 30-day window is reported in §11.5; per-class manifold radii span a 3.3× range, motivating a comparison of class-specific and fleet-wide calibration. This is descriptive evidence, not a test of intervention quality.

## The headline finding

A historical basin-label counterfactual on a 13,310-row production slice (§11.6) reports **28.9% of basin assignments changing** when a class-conditional distance score replaces the legacy fleet-wide `tanh` score on the same state vectors. Flip rates range 15–33% per class, mostly into the `low` basin. The comparison changes both the formula and calibration, so it does not isolate the benefit of class-conditional calibration. It replays basin classification, not the complete intervention decision pipeline.

The legacy coherence is nearly constant (about 0.49 in the reported deployment). The replacement changes basin labels where its values cross the classifier's operative thresholds; variation alone does not imply a basin change. The counterfactual shows that the formula choice changes basin labels, not that the new labels are correct or that agents receive different interventions.

This is a *static* reclassification measurement: the same state vectors, two coherence formulas, count the disagreements. It does not depend on the theoretical multi-agent coupling in §10 (which v6.7 reframed as a theoretical extension rather than a deployed mechanism — see *Version history* below), and its conclusion survives that correction intact.

## The methodological contribution

Re-grounding a deployed framework while service continues is a live-systems problem distinct from the mathematical one. §12 documents a **pipeline-ordering migration mechanism** that separates decision-producing from presentation-producing pipeline stages: governance verdicts fire on legacy values while the grounding computation runs as a post-verdict enrichment, so grounded values populate canonical response fields without changing live governance behavior. The mechanism generalizes beyond UNITARES — any deployed agent framework facing a semantic-coordinate change can apply it, given a request pipeline with explicit ordering between decision and presentation stages.

## Scope

Appendix B proves a corrected rate of 0.019 for the printed fixed-parameter continuous field, while trajectories remain in its stated region and share exogenous inputs. It does not certify domain invariance, an interior equilibrium, the implemented finite-step map or the adaptive governor. Appendix D records an offline counterexample at a pinned implementation revision: an interior pair expands 4.60527× in one RK4 step in the stated metric. This does not establish live instability. The grounded coordinate definitions (§4) and class-conditional calibration protocol (§8) specify research targets. The manifold-coherence path is measured per-class on production data. The `S_scale`, `I_scale`, `E_scale` constants — used only by the higher-fidelity tier-1 (logprob) and tier-2 (multi-sample) estimators — remain provenance-tagged placeholders awaiting inference-layer instrumentation. Per-class results in §11.5 are a descriptive measurement on the deployed system rather than a controlled validation study across stable parameter regimes; the paper flags this explicitly (§11.7).

The Multi-Agent Network section (§10) presents a theoretical coupled-dynamics extension — not the deployed mechanism. The within-class synchronization theorem is used only as a qualification on homogenization claims elsewhere in the paper.

## Reading aids

- **Variational free energy** (`−F`, the target semantics of the `E` coordinate) — the Free-Energy-Principle quantity measuring how well an agent's predictions match outcomes. Under that target, high `E` would mean low surprise. The deployed `E` is a heuristic estimate and is not a free-energy measurement.
- **Cosmological soup** — the failure mode of averaging a heterogeneous agent fleet into a single state distribution, in which no population structure survives normalization.
- **Manifold coherence** (`C = 1 − ‖Δ‖₂ / ‖Δ‖_max`) — distance from the agent class's healthy operating point, used as a class-conditional replacement for the legacy `tanh`-of-`V` coherence.
- **Basin flip** — a change in governance-basin assignment (`high` / `boundary` / `low`) when the same state vector is classified under different coherence formulas.

## Companion code

The deployed governance system this paper describes:
- [CIRWEL/unitares](https://github.com/CIRWEL/unitares)

The grounding implementation (Phases 1+2 referenced in §12) was merged to `master` via [PR #26](https://github.com/CIRWEL/unitares/pull/26).

## Reproducing the archived observations

The [public reproducibility kit](https://github.com/cirwel/unitares-repro-v6/tree/2d6955bf69877f2a2baa343928376896a5e254a9), archived as [Zenodo 19705151](https://doi.org/10.5281/zenodo.19705151), contains two frozen CSVs. Run its `analysis.py` to count the stored labels without a live database:

| Evidence | Rows | Stored-label flips | Rate |
|---|---:|---:|---:|
| Original April 18 table in §11.6 | 13,310 | 3,844 | 28.9% |
| Surviving April 18 submission export | 13,292 | 3,831 | 28.8% |
| Archived April 23 window | 16,879 | 7,476 | 44.3% |

The submission export is a nearby pull, **not an exact archive of the original table**. Recomputing scores from rounded coordinates is also distinct from counting its stored labels. The second window overlaps the first and uses the same frozen calibration constants; its changed rate is descriptive, not an independent replication or an established trend.

The production database no longer retains the full April windows. The historical live-query script can silently return an incomplete slice and must not be used to reproduce the headline. The exact healthy-regime input used to estimate the calibration constants is not archived here. See §11.6–11.7 for these data limits; later implementation changes do not refresh the measurements.

## Reproducing the mathematical checks

See [scripts/audits/contraction/](./scripts/audits/contraction/) for exact row arithmetic, the independent-noise and network counterexamples, and the source-pinned numerical-map example. These checks read no live outcomes or deployment data.

## Building the PDF

Either toolchain works; [Tectonic](https://tectonic-typesetting.github.io/) is preferred for reproducibility since it downloads its own font and package snapshots:

```bash
# Tectonic (self-contained, single pass)
tectonic unitares-v6.tex

# Classic TeX Live (two passes for cleveref + bibliography)
pdflatex unitares-v6.tex
pdflatex unitares-v6.tex
```

Required packages: `amsmath`, `amssymb`, `mathtools`, `bm`, `graphicx`, `booktabs`, `hyperref`, `cleveref`, `natbib`, `xcolor`, `caption`.

## Version history

Per-release notes and frozen PDFs are on the [GitHub releases page](https://github.com/CIRWEL/unitares-paper-v6/releases). Headline deltas:

- **v6.9.4 (October 13, 2026)** — separates the transform's range from its observed center, removes an unsupported causal attribution to damping, and distinguishes score variation from crossing an operative threshold. Repairs the contraction proof and limits its certificate to the printed continuous field under explicit conditions; corrects the stochastic, network, equilibrium and logistic claims. Adds source-pinned offline mathematical and numerical reproductions. Historical measured results remain unchanged. The October 13 update adds archived-data access and distinguishes basin labels from intervention decisions. Release instructions source the abstract from the exact release revision.
- **v6.9.3** — claim correction: the abstract, model section and conclusion now say the information-theoretic definitions are target semantics and the deployed estimators are tier-3 heuristics; the release retained a stability claim later corrected in v6.9.4; the 28.9% counterfactual is described as largely mechanical (the legacy coherence is nearly constant) and as showing label changes, not correctness; production start corrected to November 2025.
- **v6.8** — operational-honesty bump: §12.4 adds a paragraph on the 2026-04-20 KG retrieval rebuild (pre-rebuild semantic scores sat at noise floor; fleet-learning claims now bounded by that era); §12.5 adds item 6 explicitly caveating retrieval-infrastructure and the PR-#54 auto-ephemeral write-bug. Grounded EISV counterfactual unaffected (inputs are `core.agent_state`, not KG content).
- **v6.7** — drift correction: runtime removed the CIRS v2 neighbor-pressure coupling on 2026-04-17; paper caught up by excising §Multi-Agent Coordination and reframing §Multi-Agent Network as a theoretical extension. §11.6 headline finding unaffected.
- **v6.6** — added §11.7 identity-system-maturity disclosure; added identity hardening track to §14.5 future work.
- **v6.5** — submission polish; aligned prose with measured per-class calibration.
- **v6.4** — added facilitator-load caveat on the §11.4 dialectic statistics (45/66 non-resolution rate framed as upper-bound under human-facilitator load rather than protocol failure).
- **v6.0–v6.3** — initial v6 release and early revisions.

## Citation

The citation below identifies the published v6.9.4 PDF. Its [version DOI](https://doi.org/10.5281/zenodo.23337711) is fixed; the [concept DOI](https://doi.org/10.5281/zenodo.19647159) resolves to the latest archived version. Earlier versions, including [v6.9.3](https://doi.org/10.5281/zenodo.23110717), remain available.

```bibtex
@article{wang2026unitares-v6,
  author    = {Wang, Kenny},
  title     = {{UNITARES}: Information-Theoretic Governance of Heterogeneous Agent Fleets},
  year      = {2026},
  publisher = {Zenodo},
  doi       = {10.5281/zenodo.23337711},
  url       = {https://doi.org/10.5281/zenodo.23337711},
  version   = {v6.9.4}
}
```

The Zenodo deposit contains the paper PDF. Source, figures and audit scripts are preserved at the [release tag](https://github.com/CIRWEL/unitares-paper-v6/tree/paper-v6.9.4).

## License

Paper text and figures: [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/)

## Author

Kenny Wang, Independent Researcher
[CIRWEL Systems](https://cirwel.org)
