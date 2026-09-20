# Homework Assignment 1: Getting Started with Advanced Basketball Analytics

**Graduate — Sports Analytics.** 100 points total (5 problems, 20 points each). Due: -- set by instructor before posting --.

Submit your R script (or `.Rmd`) alongside a short write-up answering the discussion parts in plain English. Code that does not run will not receive credit for the parts that depend on it, so test each chunk before submitting.

## Problem 1: Extending the top-scorers pipeline (20 points)

In lab, we built a dplyr pipeline ranking players by points per game using `Pbox` (2017-18 season, `BasketballAnalyzeR`).

a) (8 pts) Write a pipeline that ranks the top eight players by rebounds per game, restricted to players with at least 1,000 minutes played. Show your code and the resulting table.

b) (6 pts) Rebounds per game rewards playing more minutes and playing at a faster pace, not just rebounding skill. Propose one alternative metric (using columns already available in `Pbox`, or a simple transformation of them) that would better isolate rebounding *skill* from playing time. You do not need to compute it — describe it and justify why it corrects for the issue.

c) (6 pts) Look at your top-eight list. Is there a player you expected to see who is missing, or a player you did not expect who appears? Give one basketball explanation for the surprise.

## Problem 2: Building your own assist network (20 points)

a) (10 pts) Using `PbPmanipulation()` and `assistnet()`, build the 2017-18 assist network for a team other than the Golden State Warriors. Report the `nodeStats` table sorted by total assists, and include the network plot (`plot(out)`) as an image in your write-up.

b) (5 pts) Identify the player with the highest percentage of their own made shots that were assisted, and the player with the lowest. Report both percentages.

c) (5 pts) In one paragraph, explain what the gap between those two players' assisted-shot percentages tells you about each player's offensive role, using language a coach (not a statistician) would understand.

## Problem 3: A causal trap in assist statistics (20 points)

An analyst notices that players who play more minutes per game also tend to record more assists per game, and concludes: "more playing time makes players better passers."

a) (6 pts) Sketch (describe in words, or draw and describe) a causal diagram with at least one confounding variable that could produce this same correlation without playing time causing better passing ability.

b) (6 pts) Name your confounding variable and explain, in basketball terms, why it would affect both minutes played and assists.

c) (8 pts) What analysis would you run on `Pbox` or a related dataset to check whether the confounder you named actually explains away the relationship? You do not need to run it — describe the approach and what result would support, versus undermine, the original claim.

## Problem 4: Simulating a confounded effect (20 points)

Adapt the following setup to a basketball question: suppose `T` indicates whether a shot was assisted (1) or not (0), `C` is defender distance at the time of the shot (a confounder that affects both whether a pass is thrown and whether the shot goes in), and `Y` is a made-shot quality score.

a) (8 pts) Write R code (using `set.seed()` for reproducibility) that simulates `n = 5000` shots where `C` affects both `T` and `Y`, and `T` has a true positive effect on `Y` of your choosing. Fit a crude model (`Y ~ T`) and an adjusted model (`Y ~ T + C`). Report both estimated effects.

b) (6 pts) Compare the crude and adjusted estimates to the true effect you chose. Which one is closer, and why?

c) (6 pts) Rerun your simulation with a different true effect (including a negative one). Does the direction of the bias in the crude estimate stay consistent? Explain what that tells you about assisted-shot statistics collected without accounting for defender positioning.

## Problem 5: This course's own track (20 points)

Read one of the three papers introduced this module (Muritala, Brown, & Haller, 2026; West et al., 2026; or Kanwal et al., 2025).

a) (6 pts) In two or three sentences, summarize the paper's central question and its main finding.

b) (6 pts) Identify one method or data type from the *Advanced Basketball Data Science* chapters covered so far (or previewed in Table 1.1/1.2) that could plausibly be combined with the paper's approach to study injury risk in basketball specifically, rather than the sport the paper studied.

c) (8 pts) Propose one specific indicator you could look for in play-by-play or box-score data that might function as an early-warning signal for injury risk. There is no single correct answer here — you are graded on the reasoning, not on landing on a particular indicator. What would make your proposed indicator convincing rather than coincidental?
