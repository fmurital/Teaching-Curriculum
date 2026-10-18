# Module 9 Quiz (Microsoft Forms, 8 questions, multiple choice)

Paste each question into forms.office.com as its own Choice question; mark the correct option using Forms' own settings.

**Q1.** What real, documented weakness in a single CART tree motivates moving to ensemble methods like Random Forest and Extremely Randomized Trees?

A. CART trees cannot be visualized
B. A single CART tree is statistically unstable; small changes in training data or tuning parameters can noticeably change its structure
C. CART trees cannot handle real categorical predictors
D. CART trees require more computing power than ensembles

**Q2.** How does Random Forest introduce randomness at each split, specifically?

A. It randomly discards some real training rows before fitting
B. It considers only a random subset of predictors at each split and picks the best split among just that subset
C. It builds only one real tree per model
D. It randomly reassigns the real outcome labels

**Q3.** How does Extremely Randomized Trees (Extra-Trees) push randomization further than Random Forest?

A. It uses no real randomness at all
B. Instead of searching for the best cut point for a chosen predictor, it picks a cut point at random and selects the best of a handful of such random candidates
C. It only works on real binary outcomes
D. It requires a separate real model for every predictor

**Q4.** This module's Random Forest and Extra-Trees models both reached an out-of-sample AUC near 0.64 on real 2023-24 NBA shot data. How does this compare to Zuccolotto, Sandri, and Manisera's (2023) own published result?

A. It is far lower than their real reported result
B. It is close to their own reported near-0.6 out-of-sample AUC on real 2020-21 NBA data
C. Their paper reported a perfect real AUC of 1.0
D. Their paper did not report an AUC at all

**Q5.** What real statistical bias affects Gini-based variable importance?

A. It tends to overstate the importance of continuous or high-cardinality variables, regardless of their real basketball meaning
B. It only works for real regression models, never classification
C. It always ranks every predictor equally
D. It cannot be computed from a Random Forest

**Q6.** What does permutation importance do differently from Gini importance?

A. Nothing; they are mathematically identical
B. It measures how much a real model's performance drops when a given predictor's values are randomly shuffled, making it more resistant to the high-cardinality bias in Gini importance
C. It can only be computed before training a model
D. It ignores the real outcome variable entirely

**Q7.** In this module's scoring-probability map, which real court zone showed the clearest highest-probability signal, and why is that reassuring?

A. The restricted area, because its real 66.3% field goal percentage is the highest of any zone in this dataset, confirming the model recovered a real, known pattern
B. The backcourt, because very few real shots are attempted there
C. The three-point line, because three-pointers are worth more real points
D. There was no real identifiable pattern in the map

**Q8.** What is the single biggest honest limitation of this module's models, as presented in class?

A. They used invented, simulated data
B. They cannot include real defender-proximity or shot-contest information, since this dataset does not carry that kind of player-tracking data
C. They are not real machine learning methods
D. Random Forest and Extra-Trees are mathematically the same method under different names
