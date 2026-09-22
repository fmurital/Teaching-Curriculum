# Module 5 References

- Zuccolotto, P., & Manisera, M. (2020). *Basketball Data Science: With
  Applications in R*, Chapter 3, part A ("Discovering Patterns").
  Chapman & Hall/CRC Data Science Series, CRC Press. Course textbook;
  this module maps to the correlation and player-network material in
  the first part of Chapter 3.

- Zuccolotto, Manisera & Sandri. `BasketballAnalyzeR` (R package),
  the `corranalysis()` function (used for this module's real 7-by-7
  per-minute rate correlation matrix) and the `assistnet()` function
  (used for this module's real Houston and Cleveland assist networks),
  together with the bundled `Pbox` (2017-18 NBA season player box
  scores) and `PbP.BDB` (real 2017-18 NBA regular season play-by-play,
  built around the Golden State Warriors' full 82-game schedule)
  datasets. CRAN. The direct source of every computed number in this
  module.

- Real, peer-reviewed external source on basketball passing/assist
  network analysis: "Temporal passing network in basketball: the
  effect of time pressure on the dynamics of team organization at
  micro and meso levels," published in *Psychology of Sport and
  Exercise* (Elsevier), 2025 (PubMed ID 40403945; also available as a
  preprint on arXiv, ID 2506.04808). Confirmed as a real, indexed
  publication via PubMed and ScienceDirect. Note: the full author list
  could not be confirmed from the search results available while
  building this module; consult the PubMed or ScienceDirect record
  above for the complete, verified author list before citing this
  source elsewhere. Background source for this module's framing of
  assist and passing networks as a real, published research area, not
  just a classroom exercise.

All correlation coefficients, per-minute rate figures, assist totals,
points-created figures, and network diagrams cited in this module's
notes, lab, and slides were computed directly from the real datasets
described above and can be reproduced by running
`Coding_Exercise/module5_correlation_networks.R`.
