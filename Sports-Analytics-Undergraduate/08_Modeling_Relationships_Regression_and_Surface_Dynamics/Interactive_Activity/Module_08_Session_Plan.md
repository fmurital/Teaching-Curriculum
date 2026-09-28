# Module 8 Session Plan: Modeling Relationships, Regression and Surface Area Dynamics

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From grouping to predicting

- I'll recap where Module 7 left off (clustering players and teams by
  real statistical shape) and introduce today's shift: from "what
  groups exist" to "how do two real numbers move together, and can I
  use one to predict the other."
- I'll introduce simple linear regression in plain language before
  any code, using a simple non-basketball example (height predicting
  shoe size) to set up the idea of a fitted line and R-squared.
- Live coding cue: we'll open RStudio together and build the real
  Net Rating variable from the real Four Factors output, then run
  `simplereg()` on real Net Rating against real Wins.
- We'll look at the real fitted line and real R-squared (0.9133)
  together, then I'll ask the class to find their own favorite team
  on the real table and check whether it over- or under-performs its
  real Net Rating.

**Break (10 minutes).**

## Segment 2 (50 minutes): A messier real relationship, and real variability as area

- Short lecture: not every real relationship is as strong as Net
  Rating and Wins. I'll introduce the real assist-to-turnover example
  before running it live.
- Live coding cue: we'll build the real assist-per-minute versus
  turnover-per-minute regression together (R-squared 0.4725) and look
  at the real point guard table together as a class.
- Pair discussion: using the real Chris Paul versus James Harden
  comparison, what does a real player's own decision-making add on
  top of a regression line's prediction.
- Live coding cue: we'll build the real Houston Rockets variability
  diagram together and watch the real bubbles render, then talk
  through why free throw percentage produced the real largest bubble.

**Break (10 minutes).**

## Segment 3 (50 minutes): A real correlation network and wrap-up

- Live coding cue: we'll build the real per-minute correlation
  network together and look at which real pairs survived the 0.5
  threshold.
- Small groups (3-4 students): each group picks one real correlated
  pair from the network (assists and turnovers, rebounds and blocks,
  or three-pointers made against rebounds and blocks) and writes one
  real basketball explanation for why that pair moves together,
  reporting back to the class.
- I'll close by connecting today's regression and variability work
  back to positioning and shifting and to game analysis, assign Lab
  8, the practice questions, and the Module 8 quiz, and preview
  Module 9 (the BasketballAnalyzeR applied toolkit).
