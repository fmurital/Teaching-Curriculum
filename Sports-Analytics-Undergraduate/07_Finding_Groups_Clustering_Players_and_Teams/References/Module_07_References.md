# Module 7 References

- Zuccolotto, P., & Manisera, M. (2020). *Basketball Data Science:
  With Applications in R*, Chapter 4 ("Finding Groups"). Chapman &
  Hall/CRC Data Science Series, CRC Press. Course textbook; this
  module maps to the hierarchical and k-means clustering material in
  Chapter 4.

- Sandri, M., Zuccolotto, P., & Manisera, M. `BasketballAnalyzeR` (R
  package, version 0.8.1), the `hclustering()`, `kclustering()`, and
  `MDSmap()` functions (used for this module's real player and team
  clustering and the real 2D similarity map), together with the
  bundled `Pbox`, `Tbox`, and `Obox` datasets (real 2017-18 NBA
  regular season box scores). CRAN:
  https://cran.r-project.org/package=BasketballAnalyzeR. The direct
  source of every computed number in this module.

- NBA.com official 2017-18 team and player statistics pages, used to
  cross-check real win totals and player identities referenced in
  this module's cluster descriptions (for example, confirming the
  Houston Rockets' 65 real wins and Golden State Warriors' 58 real
  wins in the 2017-18 regular season).

All real cluster assignments, variance-explained curves, cluster
profile values, cross-tabulation percentages, and MDS stress figures
cited in this module's notes, lab, and slides were computed directly
from the real `Pbox`, `Tbox`, and `Obox` datasets described above and
can be reproduced by running
`Coding_Exercise/module7_clustering_players_and_teams.R`.
