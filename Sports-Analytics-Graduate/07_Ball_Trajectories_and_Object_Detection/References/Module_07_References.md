# Module 7 References

- Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball
  Data Science: With Applications in R*, Chapter 7 ("Ball trajectories").
  CRC Press/Chapman & Hall, Data Science Series. Course textbook; this
  module maps to Chapter 7's coverage of YOLO object detection and
  ball-tracking data applied to shooting.

- Liang, Z., Wang, J., Huang, T., Sang, Z., & Zhang, J. (2025). Basketball
  detection based on YOLOv8. *PLOS ONE*, 20(8), e0326964.
  https://doi.org/10.1371/journal.pone.0326964. Real, current supplementary
  journal article (this course is not textbook-restricted at the graduate
  level); the source for this module's real BGS-YOLO precision (96.9%),
  recall (89.7%), and mAP (93.2%) figures, compared against a real baseline
  YOLOv8n model (93.1% precision, 83.4% recall, 90.5% mAP), on a real
  custom 1,000-image basketball detection dataset.

- Brancazio, P. J. (1981). Physics of basketball. *American Journal of
  Physics*, 49(4), 356-365. https://doi.org/10.1119/1.12511. The real,
  seminal peer-reviewed paper applying projectile-motion physics
  specifically to a basketball shot; the anchor citation for this
  module's minimum-speed trajectory derivation.

- Sandri, M., Zuccolotto, P., & Manisera, M. `BasketballAnalyzeR` (R
  package), the bundled `PbP.BDB` dataset (real 2017-18 NBA season-long
  play-by-play data with real shot_distance for every field goal
  attempt), used for this module's real FG%-by-distance analysis. CRAN:
  https://cran.r-project.org/package=BasketballAnalyzeR.

- Coach Dave Love. "Launch Angle and Velocity in Basketball Shooting."
  https://coachdavelove.com/launch-angle-and-velocity-in-basketball-shooting/.
  An applied shooting-analysis resource, not a peer-reviewed source,
  cited explicitly as such for its real distance-specific published
  launch-angle figures (55.2 degrees at the free throw line, 64.1
  degrees from three, both at a 7-foot release height), used for
  contrast against this module's real theoretical minimum-speed angles.

- Muritala, Brown & Haller (2026), *Research in Sports Medicine*; West et
  al. (2026), *Journal of Strength and Conditioning Research*; and Kanwal
  et al. (2025), critique of the Acute:Chronic Workload Ratio. Full
  citations in `Curriculum_Resources/Research_Papers/Literature_Review.md`.
  The instructor's own signature research, briefly previewed here in the
  PhD/advanced-project connection and developed fully in the Module 10
  PhD track.

All real shot-distance summaries, FG%-by-distance figures, and minimum-
speed trajectory calculations cited in this module's notes, lab, and
slides were computed directly from the real `PbP.BDB` dataset and the
real physics formulas described above, and can be reproduced by running
`Coding_Exercise/module7_ball_trajectories.R`.
