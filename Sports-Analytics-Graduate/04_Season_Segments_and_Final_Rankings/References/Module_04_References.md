# Module 04 References

Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball
Data Science: With Applications in R*. CRC Press / Chapman & Hall (Data
Science Series). ISBN 978-1-032-50217-5 (hbk), 978-1-032-50221-2 (pbk),
978-1-003-39744-1 (ebk). DOI 10.1201/9781003397441. Chapter 4, "The
race to the finish: exploring the relationship between season segments
and final rankings," including equations 4.1-4.2 defining `AdjRtg()`,
which this module implements directly since the textbook's own
companion `AdjRtg()` function and Italian Basketball League (LBA)
2022/23 play-by-play file are distributed only through the book's own
non-public companion files.

Kubatko, J., Oliver, D., Pelton, K., & Rosenbaum, D. T. (2007). A
starting point for analyzing basketball statistics. *Journal of
Quantitative Analysis in Sports*, 3(3), Article 1.
https://doi.org/10.2202/1559-0410.1070. The original source of the
Offensive Rating and Defensive Rating concepts (points scored/allowed
per 100 possessions) that this module's opponent-adjusted `AdjRtg()`
formula extends.

Zuccolotto, Manisera & Sandri. `BasketballAnalyzeR` (R package),
`PbPmanipulation()`, `TOPboxes()`, and `fourfactors()` functions, and
the bundled `PbP.BDB` play-by-play dataset (confirmed live, via its own
`data_set` field and per-team game counts, to be the real, complete
2017-18 NBA regular season play-by-play record for the Golden State
Warriors). CRAN. The direct source of this module's real per-game box
scores and Four Factors output.

Therneau, T., & Atkinson, B. `rpart`: Recursive Partitioning and
Regression Trees (R package). CRAN. Used for this module's real
classification and regression tree, fit on the other teams' real
segment-1 adjusted ratings to explore what predicts real wins in this
sample.

Cerqueira, N., & the `ggalluvial` package authors. `ggalluvial` (R
package). CRAN. Used to build this module's real alluvial diagram
(`module4_alluvial.png`), in the style of the textbook's own Figure
4.3.

All offensive/defensive ratings, adjusted ratings, the CART tree
output, and the alluvial and season-evolution figures cited in this
module's notes, lab, and slides were computed directly from the real
2017-18 NBA regular-season play-by-play data described above and can
be reproduced by running `Coding_Exercise/module4_season_segments.R`.
