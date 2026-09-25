# Module 05 References

Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball
Data Science: With Applications in R*. CRC Press / Chapman & Hall (Data
Science Series). ISBN 978-1-032-50217-5 (hbk), 978-1-032-50221-2 (pbk),
978-1-003-39744-1 (ebk). DOI 10.1201/9781003397441. Chapter 5,
"Understanding players' spatial dynamics" (animated plots with Voronoi
tessellation and convex hulls, monitoring speed and acceleration,
gravity and distraction, analyzing a player's spatial distribution).
This module reproduces the chapter's convex-hull, Voronoi, and spatial-
distribution techniques on real shot-location data, since the
textbook's own frame-by-frame optical tracking data is not publicly
redistributed.

NBA Advanced Stats (NBA.com). "Intro to Gravity" (2025). Official
description of the NBA's real Gravity stat: a 3D pose-detection system
tracking 29 points on every player's body, 60 times per second, used
to measure how much defensive attention a player draws relative to a
model's expectation. https://www.nba.com/news/intro-to-gravity-stat-nba-2025.
The real, tracking-based metric this module's convex-hull and Voronoi
results approximate with event-level shot data instead.

Barron, B., Sitaraman, N., & Arias, T. (2025). Analyzing NBA player
positions and interactions with density-functional fluctuation theory.
*Scientific Reports*. A real, current, peer-reviewed paper adapting
density-functional fluctuation theory (originally a physics method for
quantum systems) to real NBA player-tracking data, finding that the
real gap between elite and poor real defensive positioning is worth
approximately 3 points saved per game, and that real centers defend
2-point shots well but 3-point shots poorly compared to real wings.
https://www.nature.com/articles/s41598-025-04953-x.

Zuccolotto, Manisera & Sandri. `BasketballAnalyzeR` (R package),
`PbPmanipulation()` function and the bundled `PbP.BDB` dataset (real
2017-18 NBA regular season play-by-play, built around the Golden State
Warriors' full 82-game schedule, including each real shot's own court
coordinates). CRAN. The direct source of this module's real convex
hulls, Voronoi seeds, and kernel densities.

Turner, R. `deldir`: Delaunay Triangulation and Dirichlet (Voronoi)
Tessellation (R package). CRAN. Used to build this module's real
Voronoi tessellation of GSW players' real median jump-shot locations.

Venables, W. N., & Ripley, B. D. `MASS` (R package), `kde2d()`
function. Used to build this module's real two-dimensional kernel
density estimates of shot location.

All hull areas, Voronoi seed locations, and kernel-density figures
cited in this module's notes, lab, and slides were computed directly
from the real `PbP.BDB` shot-location data described above and can be
reproduced by running `Coding_Exercise/module5_spatial_dynamics.R`.
