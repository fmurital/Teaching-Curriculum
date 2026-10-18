# Assignment 3: Building and Reading Real Scoring Probability Models

**Sports Analytics (Graduate)** -- covers Modules 7-9 (ball trajectories and object detection, performance maps and court segmentation, machine learning models for scoring probability).

**Due:** -- set by instructor before posting --

**Total: 100 points (4 problems, 25 points each)**

This assignment has you build your own small, real scoring-probability model and then critically read the real, larger model this course already built in Module 9 (`module09_model_comparison.csv`, `module09_variable_importance.csv`, real random forest and extremely randomized trees models fit on 218,701 real shots).

## Problem 1 -- Concepts (15 points)

a. (8 pts) In one or two sentences, explain what a court-segmentation scheme (dividing the floor into zones) buys you that treating every (x, y) shot location as a unique point does not.
b. (7 pts) Name one real limitation of using 2D (x, y) shot-location data (the kind `BasketballAnalyzeR` and this course's play-by-play data provide) to study shot trajectories or launch angles, compared to real 3D optical tracking data.

## Problem 2 -- Build your own real model (35 points)

Using `PbP.BDB`, filter to Klay Thompson's real shot attempts (made and missed) for the 2017-18 season.

a. (10 pts) Fit a logistic regression predicting whether a shot is made from shot distance alone. Report the coefficient on distance and its sign, and explain in one sentence what that sign means in basketball terms.
b. (10 pts) Using your fitted model, report the model's predicted field goal percentage at 3 feet, at 23 feet, and at 30 feet.
c. (10 pts) Compute the "majority class" baseline accuracy (always predicting the more common outcome, make or miss) and compare it to your logistic model's accuracy at a 0.5 probability threshold. Report both numbers.
d. (5 pts) Based on (c), how much real predictive lift does shot distance alone provide over the naive baseline? Is this consistent with, smaller than, or larger than what you would expect from a single feature?

## Problem 3 -- Reading this course's own real model (25 points)

Open `module09_model_comparison.csv` and `module09_variable_importance.csv`.

a. (10 pts) Report both models' real AUC values and the real number of training and test shots used.
b. (10 pts) The top real variable by importance is `time_remaining_period`, ahead of both shot-location variables (`LOC_Y`, `LOC_X`) and shot distance. Propose one specific, real basketball explanation for why time remaining in the period could carry this much predictive weight for whether a shot goes in.
c. (5 pts) Compare the Random Forest AUC (0.6386) and Extremely Randomized Trees AUC (0.6400) from Module 9 to your own single-feature logistic regression's accuracy lift from Problem 2d. Which model used more information, and did using more information produce a correspondingly large improvement?

## Problem 4 -- An interpretation trap: is AUC 0.64 a failure? (25 points)

A classmate says: "An AUC of 0.64 is barely better than a coin flip at 0.50, so this entire modeling exercise in Module 9 was basically pointless -- the model doesn't really predict anything useful."

a. (15 pts) Is this a fair characterization? Explain what AUC actually measures, and why a value meaningfully above 0.50 (even if well below 1.0) can still represent real, usable information, particularly for a task like shot-make prediction where a huge amount of real randomness (a shooter's touch on a given possession) is irreducible no matter how good the model is.
b. (10 pts) Propose one specific, real way this course's Module 9 model (AUC around 0.64) could still be useful to a real team or broadcast product, despite being far from a perfect predictor.
