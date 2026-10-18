# Assignment 3: Clustering, Regression, and the Applied Toolkit

**Sports Analytics (Undergraduate)** -- covers Modules 7-9 (clustering, regression and surface area dynamics, and the `BasketballAnalyzeR` applied toolkit).

**Due:** -- set by instructor before posting --

**Total: 100 points (4 problems, 25 points each)**

This assignment uses the real 2017-18 season data (`Tbox`, `Obox`). Submit your script, any plots, and your written answers.

## Problem 1 -- Clustering teams by style (25 points)

a. (6 pts) Using `Tbox` and `Obox`, compute each team's offensive Four Factors (eFG%, TOV%, ORB%, FT Rate) for the 2017-18 season.
b. (12 pts) Standardize these four variables and run k-means clustering with k = 4 clusters. Report, for each cluster, which teams belong to it.
c. (7 pts) Compute the average win total within each of your four clusters. Which cluster has the best average record, and what do its Four Factors values have in common that might explain this?

## Problem 2 -- Regression: what predicts wins? (25 points)

a. (12 pts) Fit a linear regression predicting season win total from Offensive Rating and Defensive Rating (both computed the same way as in Assignment 1).
b. (8 pts) Report the R-squared of your model and the estimated coefficient on each predictor. Interpret, in words, what the sign of the Defensive Rating coefficient means.
c. (5 pts) Using your fitted model, predict the win total for a hypothetical team with an Offensive Rating of 112 and a Defensive Rating of 104.

## Problem 3 -- Putting the toolkit together (25 points)

Pick any one real NBA team from the 2017-18 season that your group has not already analyzed in a previous assignment this semester.

a. (10 pts) Report that team's Four Factors, Pace, Offensive Rating, and Defensive Rating, and state whether each factor is above or below the league average.
b. (10 pts) Using your regression model from Problem 2, compute that team's model-predicted win total and compare it to the team's actual win total. Is the model's prediction close, or does the team over- or under-perform what its Offensive and Defensive Rating alone would predict?
c. (5 pts) Suggest one possible real-basketball reason (not purely statistical) for any gap you find between predicted and actual wins (for example: injuries, strength of schedule, or late-season lineup changes). You do not need data to support this -- a reasonable, specific hypothesis is enough.

## Problem 4 -- A clustering trap (25 points)

Two teams can fall into the same style cluster (similar Four Factors profile) while having very different win totals, and two teams in different clusters can have nearly identical records.

a. (15 pts) Using your results from Problem 1, find one specific example of this from your own cluster assignments and win totals (name the two teams and their win totals). Explain, using a concept from this course, why teams with a similar statistical "style" can still have very different success.
b. (10 pts) A classmate argues: "If two teams are in the same cluster, they are basically the same team." Explain what is wrong with this claim, referencing the specific limitation of clustering as a method that we have discussed in class.
