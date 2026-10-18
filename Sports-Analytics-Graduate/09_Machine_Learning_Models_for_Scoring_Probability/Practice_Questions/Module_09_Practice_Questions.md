# Module 9 Practice Questions (ungraded)

1. Explain, in your own words, the real difference between how Random Forest and Extremely Randomized Trees each introduce randomness into their trees.
2. Zuccolotto, Sandri, and Manisera (2023) found that removing up to 20% of training shots visibly changed a single CART tree's structure. Why does building an ensemble of many trees make a model more resistant to this kind of instability?
3. This module's Random Forest and Extra-Trees models both reached an out-of-sample AUC near 0.64. Is an AUC of 0.64 "good"? What would you need to know before answering that question responsibly?
4. What real statistical bias does Gini importance carry, and why did it rank time remaining in the period above shot location in this module's model?
5. What does permutation importance measure that Gini importance does not, and why does that make it more resistant to the bias in question 4?
6. The real restricted-area field goal percentage in this dataset was 66.3%, by far the highest of any shot zone. Why is it reassuring, methodologically, that the model's scoring-probability map recovers this pattern on its own?
7. Name one real predictor this module's dataset does not include that you would expect to meaningfully improve shot-outcome prediction if it were available, and explain why.
8. This module's models were trained on the full real 2023-24 league. What real tradeoff would you face if you instead trained a separate model for every individual team?
