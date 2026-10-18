# Module 9 Session Plan: Machine Learning Models for Scoring Probability

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From one tree to a forest

- I'll recap Module 8's CART-based performance maps and their real, documented instability problem, then frame today's question: what do you gain from building many trees instead of one.
- Video: the concept-explainer on how a classification tree actually splits data, as a refresher before layering ensemble logic on top of it.
- Short lecture: introduce Random Forest's random-subset-of-predictors logic and Extremely Randomized Trees' random-split-point logic, side by side, in plain terms before any code.
- Live coding cue: we'll open RStudio together and prepare the real 2023-24 shot log, building the train and test split together.

**Break (10 minutes).**

## Segment 2 (50 minutes): Fitting, testing, and reading the real results honestly

- Live coding cue: we'll fit both real ensembles together and compute each one's real out-of-sample AUC.
- I'll connect our real 0.639 and 0.640 AUC results directly to Zuccolotto, Sandri, and Manisera's (2023) own published near-0.6 finding, and discuss why that ceiling is a real, honest limitation rather than a modeling failure.
- Live coding cue: we'll generate the real scoring-probability map together and look for the restricted area signal.
- Class discussion (talking points in speaker notes, not slides): what the probability map does and does not tell a coaching staff.

**Break (10 minutes).**

## Segment 3 (50 minutes): The variable-importance trap, and closing the ML arc

- Short lecture: present the real Gini-importance result (time remaining in the period ranked above shot location) as a live methodological puzzle, not a finished finding.
- Live coding cue: we'll refit with permutation importance together and compare the two real rankings directly.
- Interactive activity: small groups each take one of this module's two models and prepare a real, honest one-minute summary of what it can and cannot be trusted to say, for an audience of a front office that has not taken this course.
- Closing: tie this module back to the CART-to-ensemble arc across Modules 8 and 9, and preview how the PhD-track Module 10 extends this same habit of methodological scrutiny to injury-risk modeling.

## Before next class

Lab 9, the Module 9 quiz, and the practice questions.
