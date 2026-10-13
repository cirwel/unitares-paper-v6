# UNITARES v6 — Release preparation

The source, PDF and metadata are prepared as **v6.9.4**, dated October 13,
2026. Archive publication is pending. Preparing or merging this revision does
not publish it; the latest verified archived revision remains `paper-v6.9.3`
(version DOI `10.5281/zenodo.23110717`). The intended tag is `paper-v6.9.4`.

The deposit artifact is `unitares-v6.pdf`; `.zenodo.json` supplies the
description and publication metadata. The existing publication workflow uses
the full tag (`paper-v6.9.4`) as Zenodo's version string. The reviewed Git tag
retains source, figures and audit scripts; the Zenodo deposit is PDF-only.

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

The draft suffix has been removed consistently and the planned publication
date in `.zenodo.json` is `2026-10-13`. After the deposit is confirmed, add its
version DOI and actual `date-released` to `CITATION.cff`, update the citation
and latest-published pointers in `README.md`, and remove the pending status.
If publication occurs on another date, update the release metadata first. The version synchronization script edits both this repository and
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
replace a prior version's claims or artifacts. This revision does not assert
that the existing live deposits have been audited.
