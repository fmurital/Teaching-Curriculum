# Module 5 Session Plan: Discovering Patterns, Correlation and Player Networks

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From one variable to many, real correlation

- I'll recap where Module 4 left off and introduce today's shift: instead
  of one variable at a time, we're going to look at how several real box
  score stats relate to each other at once (5 min).
- I'll introduce the correlation coefficient in plain language,
  what -1, 0, and 1 each mean, before we touch any code (10 min).
- We'll build the real per-minute rate variables together, live in
  RStudio, filtering `Pbox` down to the 361 real players with at least
  500 minutes played (15 min).
- We'll run `corranalysis()` together and look at the real 7-by-7
  correlation matrix and its plotted version as a class (15 min).
- I want you to turn to a partner and find the three strongest real
  correlations in the matrix before I walk through what each one means
  (5 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Reading the real correlations

- Short lecture: I'll walk through the real offensive/defensive
  rebound correlation (0.729) and the real offensive rebound/block
  correlation (0.630), and why both come down to the same underlying
  skill of playing near the basket (15 min).
- Short lecture: I'll walk through the real assist/turnover correlation
  (0.687) and why a "bad" stat and a "good" stat can move together
  once you think about usage and ball-handling volume (15 min).
- Discussion: I'll ask the class to propose one more real pair of
  stats from the matrix they think might be correlated, and we'll
  check the real number together (10 min).
- I'll introduce today's second half: correlation shows which stats
  move together, but not who actually creates offense for whom on a
  real team, which is what assist networks are for (10 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Real assist networks, Houston versus Cleveland

- We'll build Houston's real assist network together, live, using its
  three real 2017-18 regular-season games against Golden State, and
  look at who led the team in real assists and points created (15 min).
- We'll build Cleveland's real assist network the same way, using its
  two real 2017-18 regular-season games against Golden State, including
  the real Christmas Day game (15 min).
- Small groups (3-4 students): each group compares the two real
  networks and decides whether Houston's or Cleveland's offense looks
  more "hub and spoke" versus distributed, using the real assist share
  numbers, then reports out (10 min).
- I'll close by connecting this to real team construction and roster
  dependency questions, assign Lab 5, the practice questions, and the
  Module 5 quiz, and preview Module 6 (event density and shooting
  under pressure) (10 min).
