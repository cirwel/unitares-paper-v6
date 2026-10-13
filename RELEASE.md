# UNITARES v6 — Release record and procedure

**v6.9.4 was published on October 13, 2026.**

- GitHub release/tag: [`paper-v6.9.4`](https://github.com/CIRWEL/unitares-paper-v6/releases/tag/paper-v6.9.4)
- Tagged source revision: `bea98859949709494ccf368d63fc3f36213c50d6`
- Version DOI: [10.5281/zenodo.23337711](https://doi.org/10.5281/zenodo.23337711)
- Concept DOI: [10.5281/zenodo.19647159](https://doi.org/10.5281/zenodo.19647159)

The deposited artifact is `unitares-v6.pdf` (33 pages). The publicly downloaded
Zenodo file and GitHub release asset were verified against the approved PDF:
SHA-256 `f5491a859333a6765340d4398a785a2ef85f1453d9026629479b953fdfb11e86`;
MD5 `a92d2c1aedceee052703192b8c70cc1a`. The public record's title, description,
publication date and version were checked. The archive uses the full tag
`paper-v6.9.4` as its version string.

The Zenodo deposit is PDF-only. Source, figures and audit scripts remain at the
reviewed Git tag. The prior [v6.9.3 deposit](https://doi.org/10.5281/zenodo.23110717)
is preserved. `.zenodo.json` supplied the publication metadata; `CITATION.cff`
and the README now identify the verified version DOI.

## Source of release metadata

Use the abstract between `\begin{abstract}` and `\end{abstract}` in
`unitares-v6.tex` at the exact revision selected for release. Convert LaTeX
notation to readable plain text or HTML without changing the claims. There is
no separately maintained abstract to copy from this file.

Before a release, check that the abstract in `CITATION.cff` and the description
in `.zenodo.json` match that source. In particular, retain the distinctions
between target semantics and deployed estimators, the scope of the contraction
certificate, basin labels versus intervention decisions, and the distinction
between the historical table and its nearby archived export. Per-class calibration is
already reported in this paper; higher-tier estimators remain future work.

## Prepare a reviewable revision

1. Confirm the source version, PDF title, `CITATION.cff` version and
   `.zenodo.json` version/notes agree. Drafts must remain labeled unpublished;
   omit `date-released` until there is an actual release date.
2. Build with `tectonic unitares-v6.tex` (or the documented two-pass TeX Live
   build). Inspect the compiled pages and verify the version and abstract.
3. Commit the source, PDF, reader documentation and metadata together. Record
   the changed claims and validation in the pull request.

## Publish only when the author chooses to release

For a future release, remove any draft suffix consistently and set the planned
publication date. After the deposit is confirmed, add its version DOI and
actual `date-released` to `CITATION.cff`, update the README citation and
latest-published pointers, and remove any pending status. If publication occurs
on another date, update the release metadata first. The version synchronization
script edits both this repository and
its companion UNITARES checkout, so inspect its scope before using it. It does
not rebuild the PDF or synchronize the abstract.

Select the exact reviewed revision for the release tag. A GitHub Release
publication triggers `.github/workflows/zenodo-publish.yml`, which uploads the
PDF and metadata to Zenodo. A branch push or pull request does not trigger that
publication workflow. The tag guard checks citation-version agreement and
whether publication completed; it does not publish on the author's behalf.

After publication, verify the GitHub asset and Zenodo record against the
released PDF, version, abstract and date before claiming the deposit is current.
Keep the concept DOI (`10.5281/zenodo.19647159`) distinct from the new version DOI.
Corrections to an archived paper belong in a new version; do not silently
replace a prior version's claims or artifacts. The verification record above
applies to v6.9.4; it is not a re-audit of every prior deposit.
