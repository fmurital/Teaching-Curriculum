# Module 4 Practice Questions (ungraded)

1. What is the difference between what this module's "season segments"
   split measures and what Module 3's "clutch versus general" split
   measured, and what stays the same about the underlying approach?

A. They measure identical things; the only difference is the dataset used
B. Module 3 split possessions within a single game by time remaining and score margin; this module splits an entire season's games chronologically into two halves; both compare a team's performance in one real subset of data against another
C. Module 3 split by season half; this module splits by clutch versus general
D. There is no underlying approach in common between the two modules

2. This module uses a real dataset substitution, just as Module 3 did.
   Which of the following correctly describes it?

A. A private 2022-23 Italian Basketball League file, the same one the textbook uses
B. `BasketballAnalyzeR::PbP.BDB`, the complete real 2017-18 NBA regular season for Golden State (82 games), described as "hub and spoke" because every other team appears only in its own games against GSW, with no two non-GSW teams ever playing each other in this dataset
C. Simulated season data generated to match the textbook's format
D. Real 2018 NBA playoff data, the same dataset Module 3 used

3. Golden State's real offensive rating barely changed between the two
   real season segments (111.89 to 112.26), while their real defensive
   rating rose from 102.03 to 106.79. What does that pattern say
   happened over the course of the real 2017-18 season?

A. The team collapsed and stopped being competitive in the second half
B. Golden State's offense stayed essentially flat across the season while its defense measurably loosened in the second half, even though the team remained a clearly strong, winning team in both halves
C. Both offense and defense improved by the same amount
D. The offensive rating numbers show the team got worse at scoring

4. What does an "adjusted" offensive or defensive rating correct for,
   compared to a plain (unadjusted) offensive or defensive rating?

A. It corrects for how many minutes a player was on the floor
B. It corrects a team's rating for the strength of the specific opponents it played, so a team padding its numbers against weak opponents sees its adjusted rating fall back toward the pack
C. It corrects for home-court advantage only
D. It corrects for the number of three-point attempts a team takes

5. Golden State's real `AORtg` and `ADRtg` compute to exactly 0.00 in
   this dataset, in every segment. What is the real mechanism behind
   that result?

A. GSW genuinely had a perfectly average offense and defense that season
B. Almost every GSW opponent in this dataset appears only in its own games against GSW, so that opponent's own rating (the benchmark used to adjust GSW's number) collapses to being identical to GSW's own performance against them, canceling the adjustment out to zero
C. `AdjRtg()` always returns 0.00 for the best team in any dataset
D. The result is a coding bug that has not yet been fixed

6. Portland, which also only appears in this dataset playing GSW, still
   gets a real, non-zero `AORtg` of 13.55. Why doesn't Portland's
   adjusted rating collapse the same way GSW's does?

A. Portland's adjustment subtracts GSW's own defensive rating, which is built from roughly twenty-five to thirty different real opponents, a genuine outside benchmark, unlike GSW's own one-off opponents
B. Portland's games are excluded from the calculation entirely
C. Portland's adjusted rating also collapses to 0.00, just like GSW's
D. Portland played a full 82-game season, unlike GSW

7. The real CART tree fit on the other teams' segment-1 adjusted
   ratings found its first split at `AORtg1 < -0.015`. Why should this
   tree be read as an exploratory, data-driven pattern rather than a
   validated predictive finding?

A. Because CART trees can never be trusted for any real dataset
B. Because most teams in the fit contribute only two to four real games, making it a demonstration of the method on a small, honestly noisy sample rather than a validated, generalizable finding about what causes winning
C. Because the split value of -0.015 is mathematically impossible
D. Because CART only works on datasets with at least 82 games per team

8. In a genuine round-robin dataset, like the textbook's own
   sixteen-team Italian league where every team plays every other team
   exactly twice, would the same adjusted-rating degeneracy found in
   GSW's data appear for any team? Why or why not?

A. Yes, because `AdjRtg()` always produces zero for the best team in any league
B. No, because every team's opponent benchmark would then be built from games against many different other teams rather than collapsing to a single team's own performance, which is exactly why the method produces clean, non-degenerate results in a genuine round robin
C. Yes, because round-robin schedules always cause this exact collapse
D. No, because round-robin datasets cannot compute adjusted ratings at all
