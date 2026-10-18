# Module 6 References

- Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball Data Science: With
  Applications in R*, Chapter 6 ("Athletic motion kinematics analysis"). CRC Press/Chapman &
  Hall, Data Science Series. Course textbook; this module maps to Chapter 6's coverage of
  artificial intelligence, computer vision, deep learning, convolutional neural networks, and
  MoveNet pose estimation (sections 6.1-6.5).

- Sandri, M., Zuccolotto, P., & Manisera, M. `BasketballAnalyzeR` (R package), the
  `PbPmanipulation()` function and the bundled `PbP.BDB` dataset (real 2017-18 Golden State
  Warriors season-long play-by-play data), used for this module's real free-throw, turnover,
  and late-game field goal percentage analysis. CRAN:
  https://cran.r-project.org/package=BasketballAnalyzeR.

- Google Research / TensorFlow team. "Next-Generation Pose Detection with MoveNet and
  TensorFlow.js." TensorFlow Blog, 2021. https://blog.tensorflow.org/2021/05/next-generation-pose-detection-with-movenet-and-tensorflowjs.html.
  Official source for MoveNet's real 17-keypoint output format and the real published
  device-dependent frame-rate benchmarks for the Lightning and Thunder variants cited in this
  module's notes and slides.

- Wei, L., Yang, C., Huang, X., Tu, L., Xu, Y., Li, M., & Hu, Z. (2025). Comparison of lower
  limb kinematics and kinetics estimation of basketball players during jumping with markerless
  and marker-based motion capture systems. *Acta of Bioengineering and Biomechanics*, 27(2),
  134-145. https://doi.org/10.37190/abb/207092. Real supplementary journal article (this course
  is not textbook-restricted at the graduate level); the source for this module's real finding
  that ankle and knee joint estimates agree strongly (r >= 0.94) between marker-based and
  markerless systems while hip joint estimates show significant disagreement.

- Li, Z., Tan, Z., Zheng, W., Yang, G., Tao, J., Zhang, M., & Xu, X. (2026). Evaluating a
  multi-camera markerless system for capturing basketball-specific movements: an exploration
  using 25 Hz video streams. *Sensors*, 26(5), 1689. https://doi.org/10.3390/s26051689. Real
  supplementary journal article; the source for this module's real finding that joint
  displacement agrees strongly (r = 0.916-0.994) between a 25 Hz markerless system and a
  lab-grade reference system, while velocity and acceleration agree far less well.

- Muritala, Brown & Haller (2026), *Research in Sports Medicine*; West et al. (2026), *Journal
  of Strength and Conditioning Research*; and Kanwal et al. (2025), critique of the
  Acute:Chronic Workload Ratio. Full citations in
  `Curriculum_Resources/Research_Papers/Literature_Review.md`. The instructor's own signature
  research, previewed here and developed fully in the Module 10 PhD track, on data quality and
  workload monitoring in athlete injury risk.

All real free-throw percentage, turnover rate, and late-game field goal percentage figures
cited in this module's notes, lab, and slides were computed directly from the real `PbP.BDB`
dataset described above and can be reproduced by running
`Coding_Exercise/module6_athletic_motion_kinematics.R`.
