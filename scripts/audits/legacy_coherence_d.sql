-- legacy_coherence_d.sql
--
-- Audit of EISV component discriminative power on the live audit log.
--
-- Question: For trajectory_validated outcomes (good vs bad), how well does each
-- EISV component (and the legacy tanh-of-V coherence) discriminate?
--
-- Output: Cohen's d effect size for each component. Convention:
--   |d| < 0.2  negligible
--   0.2 - 0.5  small
--   0.5 - 0.8  medium
--   |d| > 0.8  large
--
-- Run:   psql -d governance -f legacy_coherence_d.sql
--
-- Reproduces: §11.x of v6.10. Re-runnable by any reviewer with read access
-- to the governance audit log; numbers will shift as the corpus grows but the
-- structural finding (legacy coherence d~0, S/phi d~0.8+) is stable.

\echo
\echo === EISV component discriminative power, last 30 days ===
\echo

WITH stats AS (
  SELECT
    is_bad,
    COUNT(*) AS n,
    AVG(eisv_e) AS e_mean, STDDEV(eisv_e) AS e_std,
    AVG(eisv_i) AS i_mean, STDDEV(eisv_i) AS i_std,
    AVG(eisv_s) AS s_mean, STDDEV(eisv_s) AS s_std,
    AVG(eisv_v) AS v_mean, STDDEV(eisv_v) AS v_std,
    AVG(eisv_phi) AS phi_mean, STDDEV(eisv_phi) AS phi_std,
    AVG(eisv_coherence) AS coh_mean, STDDEV(eisv_coherence) AS coh_std
  FROM audit.outcome_events
  WHERE ts > NOW() - INTERVAL '30 days'
    AND outcome_type = 'trajectory_validated'
    AND eisv_e IS NOT NULL
  GROUP BY is_bad
),
g AS (SELECT * FROM stats WHERE is_bad = false),
b AS (SELECT * FROM stats WHERE is_bad = true)
SELECT
  g.n AS n_good,
  b.n AS n_bad,
  ROUND(((b.e_mean   - g.e_mean)   / SQRT((g.e_std^2   + b.e_std^2)/2))::numeric, 3) AS d_E,
  ROUND(((b.i_mean   - g.i_mean)   / SQRT((g.i_std^2   + b.i_std^2)/2))::numeric, 3) AS d_I,
  ROUND(((b.s_mean   - g.s_mean)   / SQRT((g.s_std^2   + b.s_std^2)/2))::numeric, 3) AS d_S,
  ROUND(((b.v_mean   - g.v_mean)   / SQRT((g.v_std^2   + b.v_std^2)/2))::numeric, 3) AS d_V,
  ROUND(((b.phi_mean - g.phi_mean) / SQRT((g.phi_std^2 + b.phi_std^2)/2))::numeric, 3) AS d_phi,
  ROUND(((b.coh_mean - g.coh_mean) / SQRT((g.coh_std^2 + b.coh_std^2)/2))::numeric, 3) AS d_legacy_coherence
FROM g, b;

\echo
\echo === Per-regime breakdown: directional inversion of S validates class-conditional thesis ===
\echo

SELECT
  eisv_regime,
  is_bad,
  COUNT(*) AS n,
  ROUND(AVG(eisv_s)::numeric, 3)         AS s_mean,
  ROUND(AVG(eisv_phi)::numeric, 3)       AS phi_mean,
  ROUND(AVG(eisv_coherence)::numeric, 3) AS legacy_coh_mean
FROM audit.outcome_events
WHERE ts > NOW() - INTERVAL '30 days'
  AND outcome_type = 'trajectory_validated'
  AND eisv_e IS NOT NULL
GROUP BY 1, 2
ORDER BY 1, 2;

\echo
\echo Reading: in CONVERGENCE, bad outcomes have *lower* S (premature lock-in).
\echo In DIVERGENCE/EXPLORATION/TRANSITION, bad outcomes have *higher* S
\echo (runaway uncertainty). A flat fleet-wide S threshold gates the wrong
\echo direction for one of these regimes. Class-conditional gating is the fix
\echo the data points at.
\echo
\echo Legacy coherence is flat (~0.49) across every regime x is_bad cell.
\echo The published verdict-mapping function does not separate cases.
\echo
