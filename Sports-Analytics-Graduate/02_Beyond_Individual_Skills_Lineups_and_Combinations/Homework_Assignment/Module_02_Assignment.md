# Homework Assignment 2: Beyond Individual Skills — Lineups and Combinations

**Graduate — Sports Analytics.** 100 points total (5 problems, 20 points each). Due: -- set by instructor before posting --.

Submit your R script (or `.Rmd`) alongside a short write-up answering the discussion parts in plain English.

## Problem 1: Finding your own lineups (20 points)

a) (8 pts) Choose a team other than the Golden State Warriors from the bundled `BasketballAnalyzeR` play-by-play data. Using `lineups()` or `parlineups()`, find every 5-player combination from a 9-or-10-player pool of your choosing that played at least 30 minutes together. Report the resulting table.

b) (6 pts) Does one lineup dominate the minutes the way the Warriors' starting group did in class (346.1 of roughly 480 minutes), or is playing time spread more evenly across several combinations? What does that pattern suggest about how the coach used their roster?

c) (6 pts) Pick the two lineups from your table with the closest total minutes to each other. What is one basketball reason those two combinations might have earned nearly identical playing time despite being different groups of players?

## Problem 2: Building and interpreting a network (20 points)

a) (10 pts) Build an assist-shot network for one of your lineups from Problem 1. Report the `nodeStats` table and include the network plot.

b) (5 pts) Identify the hub of your network (the player with the most total assists in this lineup). Is it the same player who would be the hub of the team's overall assist network, or does a different player emerge when the lineup narrows?

c) (5 pts) Using a shot-distance breakdown (by hand from the box score, or with `densityplot()` if you have it working), name the best scorer at the rim, from mid-range, and from three-point range in your lineup. Is one player dominant across all three areas, or does the scoring load split up the way it did for the Warriors?

## Problem 3: A confound in lineup ratings (20 points)

A coach argues: "our bench lineup has a better Offensive Rating than our starters, so we should play the bench more."

a) (6 pts) Name one confounding variable that could produce this pattern without the bench lineup actually being better. (Hint: think about who the bench typically plays against.)

b) (6 pts) Explain, in basketball terms, why your named confounder would inflate the bench lineup's apparent Offensive Rating specifically, rather than affecting both lineups equally.

c) (8 pts) What analysis would you run to check whether opponent quality explains away the difference? You do not need to run it. Describe the approach (for example, comparing each lineup's rating only against a shared subset of opponents) and what result would support, versus undermine, the coach's claim.

## Problem 4: Simulating the confound (20 points)

a) (8 pts) Write R code (`set.seed()` for reproducibility) simulating `n = 2000` lineup-minutes, where `Q` is opponent defensive quality (a confounder, higher means a tougher opponent), `L` indicates which of two lineups is on the floor (bench lineups are more likely to face weaker opponents, i.e., lower `Q`), and `Y` is points scored per 100 possessions in that stretch. Give the bench lineup (`L = 1`) a true Offensive Rating effect of your choosing relative to the starters. Fit a crude model (`Y ~ L`) and an adjusted model (`Y ~ L + Q`).

b) (6 pts) Compare the crude and adjusted estimates of the lineup effect. Which is closer to the true effect you set, and why?

c) (6 pts) Rerun with the bench lineup's true effect set to zero (no real difference between lineups). Does the crude model still show the bench lineup as "better"? What does that tell you about the coach's original argument?

## Problem 5: Lineups as a workload signal (20 points)

a) (6 pts) Using your Problem 1 lineup table, identify the players who appear most often across your team's highest-minute combinations.

b) (6 pts) West et al. (2026) addresses statistical process control for sport-science data quality. In two or three sentences, connect its core concern to the problem of trusting minutes-played data drawn from lineup combinations like the ones you just built.

c) (8 pts) Propose one specific, checkable indicator, built from lineup data rather than individual box scores, that a coaching staff could monitor to flag a player who is accumulating workload faster than the rest of the roster. There is no single correct answer; you are graded on the reasoning, not on landing on a particular indicator.
