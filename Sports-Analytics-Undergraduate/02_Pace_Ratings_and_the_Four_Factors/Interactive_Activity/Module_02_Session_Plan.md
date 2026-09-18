# Module 2 Session Plan: Pace, Ratings, and the Four Factors

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): Pace and ratings

- Quick recap of Module 1's workflow and the `BasketballAnalyzeR` data
  (5 min).
- Lecture: why raw counting stats mislead across teams with different
  paces; live derivation of pace, ORtg, and DRtg from a possession
  definition (20 min).
- Worked example, live in RStudio: run `fourfactors(Tbox, Obox)` on the
  real 2017-18 data, pull the fastest-pace and best-rating teams (15 min).
- Cold-call discussion: does the fastest team have the most wins? Why or
  why not? (10 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): The Four Factors

- Lecture: Dean Oliver's Four Factors framework and his original
  40/25/20/15 weighting, with the definition of each factor (15 min).
- Small groups (3-4 students): each group is assigned two teams from
  `FF$Team` and computes/interprets their Four Factors, offense and
  defense, then prepares one sentence per team describing its
  identity as a team (20 min).
- Groups report out; instructor tracks results on the board next to each
  team's actual win total (15 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Net rating and the whole-league picture

- Live demo: `cor(FF$F1.Off, FF$W)` versus `cor(FF$NetRtg, FF$W)` --
  let the room react to the gap between 0.77 and 0.96 before explaining
  it (10 min).
- Walk through `plot(FF)`'s four-panel chart together, one panel at a
  time, connecting each to what the class already found in Segment 2
  (20 min).
- Tie back to the game-analysis throughline: how a broadcast analyst or
  a front-office analyst would use these numbers differently (10 min).
- Assign Lab 2, Practice Questions, and the Module 2 quiz; preview
  Module 3 (visualizing team and player profiles) (10 min).
