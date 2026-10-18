# Lab 9: Build and Compare Two Real Scoring-Probability Ensembles

## What you need

Open RStudio and load the real 2023-24 NBA shot log, the same one used in class, along with the `ranger` package.

```r
library(ranger)
shots <- read.csv("shotdetail_2023.csv", stringsAsFactors = FALSE)
```

## Step 1: Prepare the real data

Build the same real feature set from class: shot distance, court location, period, time remaining in the period, shot zone, and shot type. Hold out 20% of the real shots as a genuine test set.

```r
shots$SHOT_MADE_FLAG <- factor(shots$SHOT_MADE_FLAG, levels = c(0, 1))
shots$time_remaining_period <- shots$MINUTES_REMAINING * 60 + shots$SECONDS_REMAINING
set.seed(1)
train_idx <- sample(seq_len(nrow(shots)), size = floor(0.8 * nrow(shots)))
train <- shots[train_idx, ]
test <- shots[-train_idx, ]
```

## Step 2: Fit both real ensembles

Fit a Random Forest and an Extremely Randomized Trees model, exactly as shown in class, on your own real training split.

## Step 3: Compute a fairer variable-importance measure

Class flagged a real problem with Gini importance: it is biased toward high-cardinality continuous predictors. Refit your Random Forest with `importance = "permutation"` instead of `"impurity"`, and compare the resulting real ranking to the Gini-based ranking from class.

```r
rf_perm <- ranger(SHOT_MADE_FLAG ~ ., data = train, probability = TRUE,
                   num.trees = 300, importance = "permutation")
sort(importance(rf_perm), decreasing = TRUE)
```

## Step 4: Build your own real scoring-probability map for one real team

Filter the real shot log down to one team of your choosing before fitting a team-specific model, then generate a real probability surface the same way we did in class for the whole league.

## Reflection questions

1. Did the permutation-based importance ranking change the order of predictors compared to the Gini-based ranking from class? If so, which variable moved the most, and why does that make methodological sense given what Gini importance is biased toward?
2. Your team-specific model was trained on far fewer real shots than the league-wide model. What real tradeoff does that create, and how would you investigate whether your team-specific model is overfitting?
3. The league-wide models both landed near an out-of-sample AUC of 0.64. Is that a good result? Defend your answer using the real argument Zuccolotto, Sandri, and Manisera (2023) make about what shot-outcome prediction can and cannot realistically achieve.
4. Random Forest and Extremely Randomized Trees reached almost identical real AUC in this module. Under what real circumstances, based on how each method actually randomizes its splits, might you expect the two to diverge more?
5. This lab's model does not include any real defender-proximity or shot-contest variable, since this dataset does not carry one. If you had access to real player-tracking data with that information, which of this module's conclusions would you expect to change the most, and why?

## What to turn in

Your R script, your Gini-versus-permutation importance comparison, your team-specific probability map, and written answers to all five reflection questions.
