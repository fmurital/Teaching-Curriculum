# Module 9 References

- Zuccolotto, P., Manisera, M., & Sandri, M. (2026). *Advanced Basketball Data Science: With Applications in R*, Chapter 9 ("Scoring Probability via Machine Learning"). CRC Press / Chapman & Hall (Data Science Series). ISBN 978-1-032-50217-5. DOI: 10.1201/9781003397441. Course textbook; this module maps to the Random Forest, Oblique Random Forest, and Extremely Randomized Trees material in Chapter 9. This module's real analyses apply the chapter's general, published methodology (tree-ensemble scoring-probability models) to real shot-location data computed independently for this course, rather than reproducing the chapter's own worked example, since the private copy of this textbook currently on file does not include a text-extractable copy of Chapter 9.
- Zuccolotto, P., Sandri, M., & Manisera, M. (2023). Spatial performance analysis in basketball with CART, random forest and extremely randomized trees. *Annals of Operations Research*, 325(1), 495-519. https://doi.org/10.1007/s10479-022-04784-3. Supplementary journal article (real, peer-reviewed, by the textbook's own author team) used as this module's primary methodological source, since it is the direct published ancestor of the textbook chapter and reports real, comparable AUC results.
- Geurts, P., Ernst, D., & Wehenkal, L. (2006). Extremely randomized trees. *Machine Learning*, 63, 3-42. https://doi.org/10.1007/s10994-006-6226-1. Original method paper for Extremely Randomized Trees (Extra-Trees), cited for the method's real theoretical description.
- Menze, B. H., Kelm, B. M., Splitthoff, D. N., Koethe, U., & Hamprecht, F. A. (2011). On oblique random forests. In *Machine Learning and Knowledge Discovery in Databases (ECML PKDD 2011)*. Springer. Cited for the real methodological background on oblique (hyperplane-split) random forests, the textbook chapter's third model family, which this module introduces conceptually without a reproduced worked example, since multivariate-split tree packages were not available in this build's computing environment.
- Wright, M. N., & Ziegler, A. (2017). ranger: A fast implementation of random forests for high dimensional data in C++ and R. *Journal of Statistical Software*, 77(1), 1-17. https://doi.org/10.18637/jss.v077.i01. R package used for both real models in this module, including its `splitrule = "extratrees"` option.
- shufinskiy (2026). nba_data: NBA play-by-play and shot detail data [Data repository]. GitHub. https://github.com/shufinskiy/nba_data. Real 2023-24 regular season shot log (218,701 shot attempts) used for all real computation in this module.
- Davis, J., Bransen, L., Devos, L., Jaspers, A., Meert, W., Robberechts, P., Van Haaren, J., & Van Roy, M. (2024). Methodology and evaluation in sports analytics: Challenges, approaches, and lessons learned. *Machine Learning*. https://doi.org/10.1007/s10994-024-06585-0. Cited for this module's discussion of the Gini-importance bias as a general methodological caution in sports analytics modeling.

All real AUC figures, variable-importance rankings, and the scoring-probability map in this module's notes, lab, and slides were computed directly from the real `shotdetail_2023.csv` dataset described above and can be reproduced by running `Coding_Exercise/module09_scoring_probability.R`.

## Required reading before class

Zuccolotto, Sandri & Manisera (2023), full paper. Geurts, Ernst & Wehenkal (2006), sections 1-3.

## Optional reading

Menze et al. (2011), for students who want the oblique random forest methodology in more depth than this module's conceptual overview covers.
