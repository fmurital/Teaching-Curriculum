# Module 4 Practice Questions (ungraded)

1. Explain, in your own words, the difference between what this
   module's "season segments" split measures and what Module 3's
   "clutch versus general" split measured. What stays the same about
   the underlying approach, and what changes?

2. This module uses a different real dataset substitution than
   Module 3 did. Name the real dataset this module uses, describe its
   real coverage (which team, which season, how many games), and
   explain why it is described as having a "hub and spoke" structure.

3. Golden State's real offensive rating barely changed between the two
   real season segments (111.89 to 112.26), while their real defensive
   rating rose from 102.03 to 106.79. In plain language, what does that
   pattern say happened to this team over the course of its real
   2017-18 season?

4. In your own words, what does an "adjusted" offensive or defensive
   rating correct for, compared to a plain (unadjusted) offensive or
   defensive rating?

5. Golden State's real `AORtg` and `ADRtg` compute to exactly 0.00 in
   this dataset, in every segment. Explain the real mechanism behind
   this result: why does the adjustment term cancel out completely for
   GSW specifically?

6. A team like Portland, which also only appears in this dataset
   playing GSW, still gets a real, non-zero `AORtg`. Explain why
   Portland's adjusted rating does not collapse the same way GSW's
   does.

7. The real CART tree fit on the other teams' segment-1 adjusted
   ratings found its first split at `AORtg1 < -0.015`. Why should this
   tree be read as an exploratory, data-driven pattern rather than a
   validated predictive finding?

8. Suppose you were handed a new dataset where, instead of one team's
   full season against many one-off opponents, every team played every
   other team exactly twice (a genuine round robin, like the
   textbook's own sixteen-team Italian league). Would you expect the
   same adjusted-rating degeneracy this module found in GSW's data to
   appear for any team in that new dataset? Explain why or why not.
