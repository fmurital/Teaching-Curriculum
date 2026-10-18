# Assignment 1: From Box Scores to Networks, Lineups, and Situational Splits

**Sports Analytics (Graduate)** -- covers Modules 1-3 (getting started with advanced basketball analytics, lineups and combinations, clutch performance and situational splits).

**Due:** -- set by instructor before posting --

**Total: 100 points (4 problems, 25 points each)**

This assignment uses the real 2017-18 NBA season data built into `BasketballAnalyzeR` (`Pbox`, `Tbox`, `Obox`). Use the Denver Nuggets as your team unless a problem tells you otherwise -- a team we have not yet worked with together in Modules 1-3. This assignment goes one step further than the undergraduate course's parallel assignment: instead of a single bivariate relationship, you will compare a multi-predictor model against a simpler one and reason about why more predictors do not automatically mean a better model.

## Problem 1 -- Concepts and the pipeline (25 points)

a. (8 pts) In your own words, explain what `PbPmanipulation()` does to raw play-by-play data, and name one derived variable it creates that is not present in the raw data.
b. (9 pts) Explain, at a conceptual level, why an assist network (nodes = players, edges weighted by assists) captures something that a single season-long assist-total leaderboard cannot.
c. (8 pts) This course's graduate-level track draws on real, current journal articles in addition to the textbook. Name one of the three signature papers introduced in Module 1 and, in one sentence, say what question it addresses.

## Problem 2 -- A real team profile (25 points)

a. (10 pts) Using `Pbox`, filter Denver Nuggets players with at least 500 minutes played in 2017-18 and report a table ranked by points per game.
b. (10 pts) Compute Denver's Four Factors, Pace, Offensive Rating, and Defensive Rating, and compare each to the real league average, stating above/below for each.
c. (5 pts) Based on (b), is Denver's clearest strength or weakness on offense or defense? Justify with a specific number.

## Problem 3 -- Does more always mean better? A real model comparison (25 points)

a. (10 pts) Fit two real regression models predicting season win total across all 30 teams: Model A uses only Net Rating (Offensive Rating minus Defensive Rating) as a predictor; Model B uses all four offensive Four Factors (eFG%, TOV%, ORB%, FT Rate) plus Pace as predictors. Report the R-squared and AIC of each model.
b. (10 pts) Despite having five predictors instead of one, does Model B outperform Model A? Report both AIC values and state which model AIC says is better (remember: lower AIC is better). Explain, in a sentence or two, what Model B's predictor set is missing that would explain this result.
c. (5 pts) Name one real pair of predictors in Model B that are correlated with each other (report the correlation), and explain briefly why that kind of overlap can make a multi-predictor model harder to interpret even when it does not hurt its raw fit much.

## Problem 4 -- A graduate-level interpretation trap (25 points)

A classmate says: "Model B has five real predictors and Model A only has one, so Model B must capture more of what actually drives winning, even if Model A's R-squared happens to be a little higher."

a. (15 pts) Is this reasoning sound? Using your own results from Problem 3, explain specifically what is wrong (or right) about defining "capturing more of what drives winning" by predictor count rather than by what the predictors actually represent.
b. (10 pts) Propose one specific additional real predictor (not already in Model B) that you would add to try to close the gap with Model A, and explain in one sentence why you expect it to help.
