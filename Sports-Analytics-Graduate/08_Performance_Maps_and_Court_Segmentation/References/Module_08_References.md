# Module 8 References

- Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced
  Basketball Data Science: With Applications in R*, Chapter 8
  ("Basketball Performance Maps Based on Court Segmentation"). CRC
  Press / Chapman & Hall (Data Science Series). ISBN
  978-1-032-50217-5. DOI: 10.1201/9781003397441. Course textbook;
  this module maps to the sector-based performance map, shot chart,
  and CART (Cartesian and polar) material in Chapter 8. This
  module's real analyses apply the chapter's general, published
  methodology (sector maps, shot charts, CART-based scoring
  probability maps on Cartesian and on polar shot coordinates) to
  real shot-location data computed directly for this course, rather
  than reproducing the chapter's own worked example, since the
  private copy of this textbook currently on file covers chapters
  through part of Chapter 5.

- Sandri, M., Zuccolotto, P., & Manisera, M. `BasketballAnalyzeR` (R
  package), the `PbP.BDB` play-by-play dataset and `PbPmanipulation()`
  and `drawNBAcourt()` functions, used for this module's real shot
  location data and real shot chart. CRAN:
  https://cran.r-project.org/package=BasketballAnalyzeR.

- Therneau, T., & Atkinson, B. `rpart` (R package), the Classification
  and Regression Tree implementation used for both real CART models
  in this module. CRAN: https://cran.r-project.org/package=rpart.

- Milborrow, S. `rpart.plot` (R package), used to render both real
  CART trees in this module's figures. CRAN:
  https://cran.r-project.org/package=rpart.plot.

All real sector-map percentages, shot chart data, CART tree
structures, and model accuracy figures cited in this module's notes,
lab, and slides were computed directly from the real `PbP.BDB`
dataset described above and can be reproduced by running
`Coding_Exercise/module8_performance_maps.R`.
