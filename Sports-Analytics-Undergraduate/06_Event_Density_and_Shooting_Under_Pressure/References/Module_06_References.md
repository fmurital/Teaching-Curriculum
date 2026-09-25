# Module 6 References

- Zuccolotto, P., & Manisera, M. (2020). *Basketball Data Science: With
  Applications in R*, Chapter 3, part B ("Discovering Patterns").
  Chapman & Hall/CRC Data Science Series, CRC Press. Course textbook;
  this module maps to the event density and shot-timing material in
  the second part of Chapter 3.

- Zuccolotto, Manisera & Sandri. `BasketballAnalyzeR` (R package), the
  `densityplot()` function (used for this module's real shot-clock
  event density plots, including the best-scorer overlay), together
  with the bundled `PbP.BDB` dataset (real 2017-18 NBA regular season
  play-by-play, built around the Golden State Warriors' full 82-game
  schedule). CRAN. The direct source of every computed number in this
  module.

- NBA Advanced Stats (NBA.com/stats). Official definition of "clutch
  time" used by the league's own stats platform: the last 5 minutes of
  the fourth period or overtime, with the score margin within 5
  points. This module's real clutch-time split
  (`period >= 4 & periodTime >= 420 & abs(home_score - away_score) <= 5`)
  applies that same definition directly to `PbP.BDB`'s real event
  data. See https://www.nba.com/stats/players/clutch-traditional for
  the league's own clutch-time leaderboards built on this definition.

All shot-clock bucket percentages, clutch-time percentages, and
player-level clutch attempt figures cited in this module's notes, lab,
and slides were computed directly from the real `PbP.BDB` dataset
described above and can be reproduced by running
`Coding_Exercise/module6_event_density_pressure.R`.
