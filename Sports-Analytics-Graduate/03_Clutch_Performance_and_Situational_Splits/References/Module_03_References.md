# Module 03 References

Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball
Data Science: With Applications in R*. CRC Press / Chapman & Hall (Data
Science Series). ISBN 978-1-032-50217-5 (hbk), 978-1-032-50221-2 (pbk),
978-1-003-39744-1 (ebk). DOI 10.1201/9781003397441. Chapter 3, "Drilling
down on clutch splits."

Zuccolotto, P., Manisera, M., & Sandri, M. (2018). Big data analytics
for modeling scoring probability in basketball: The effect of shooting
under high-pressure conditions. *International Journal of Sports
Science & Coaching*, 13(4), 569-589.
https://doi.org/10.1177/1747954117737492. The paradigm this module's
clutch indices (`SP`, `SPc`, `Diff`, `Pr_c`, `MINcp`) come from,
referenced directly in the textbook chapter this module covers.

Goldman, M., & Rao, J. M. (2012). Effort vs. concentration: The
asymmetric impact of pressure on NBA performance. *MIT Sloan Sports
Analytics Conference*.
https://www.sloansportsconference.com/research-papers/effort-vs-concentration.
Supplementary source, not from the textbook, connecting this module's
`Diff`/`Prc` player indices to a broader argument about how pressure
affects NBA performance asymmetrically.

Zuccolotto, Manisera & Sandri. `BasketballAnalyzeR` (R package),
`PbPmanipulation()`, `TOPboxes()`, `fourfactors()`, `inequality()`, and
`bubbleplot()` functions, and the bundled `PbP.BDB` play-by-play dataset
(2017-18 NBA playoffs). CRAN. The direct source of this module's team
and player clutch splits.

All team ratings, Four Factors values, Gini coefficients, and player
clutch indices cited in this module's notes, lab, and slides were
computed directly from the real 2017-18 NBA playoff play-by-play data
described above and can be reproduced by running
`Coding_Exercise/module3_clutch_splits.R`.
