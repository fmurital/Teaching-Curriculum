# Module 3 Practice Questions (ungraded)

1. This module defines "clutch" with a precise, reproducible rule
   rather than an impressionistic judgment of which moments "felt"
   clutch. What is that exact definition?

A. Any point in the fourth quarter, regardless of score
B. Fewer than 5 minutes remaining (including overtime) and a score difference of 5 points or less
C. Fewer than 10 minutes remaining and any score difference
D. A score difference of exactly 0, at any point in the game

2. This module reproduces the textbook's Chapter 3 methodology on a
   different real dataset than the textbook itself uses. What is that
   substitution, and why is it still a legitimate way to teach the
   method?

A. It uses simulated data instead of real data, which is legitimate because the formulas are unaffected by real versus simulated input
B. It uses `BasketballAnalyzeR::PbP.BDB` (real 2017-18 NBA playoff play-by-play) instead of the textbook's private 2021-22 Celtics/Warriors file, applying the identical PbPmanipulation/TOPboxes/fourfactors/inequality pipeline to real, public, reproducible data
C. It uses only Boston's data and drops Golden State entirely
D. It uses 2022-23 regular season data instead of playoff data

3. In this module's real 2018 clutch sample, Golden State's offensive
   rating fell from 112.8 (General) to 108.7 (Clutch), while their
   defensive rating rose from 103.8 to 115.4. Which side of their game
   degraded more?

A. Their offense, since 112.8 to 108.7 is a larger raw point swing
B. Their defense, since DRtg rose by 11.6 points (103.8 to 115.4) while ORtg fell by only 4.1 points (112.8 to 108.7)
C. Neither; both sides degraded by an identical amount
D. Their offense, because Offensive Rating is always weighted twice as heavily as Defensive Rating

4. The Gini coefficient in this module's scoring inequality analysis
   measures how unequally points are distributed across a team's
   players. What would a value of 0% and a value of 100% each mean?

A. 0% means the team scored zero points; 100% means the team scored every possible point
B. 0% means every player scored an equal share of the team's points; 100% means one single player scored all of it
C. 0% and 100% are not valid Gini values in basketball data
D. 0% means the team lost; 100% means the team won

5. In the player-level clutch indices, what does a large positive
   `Pr_c` value mean about a player's shot-taking behavior in the
   clutch, specifically relative to their clutch minutes played?

A. The player is taking a disproportionately larger share of the team's shots in the clutch than their share of clutch minutes played would predict
B. The player never takes a shot during clutch situations
C. The player's shooting efficiency improved in the clutch
D. `Pr_c` only measures defensive rebounding, not shot-taking

6. Kyrie Irving's real `Pr_c` in this module's Boston sample was 189.8,
   far larger than any Golden State player's. Which of the following is
   a reasonable real basketball explanation for why Boston's clutch shot
   distribution might be this much more concentrated in one player than
   Golden State's?

A. Boston's roster construction that postseason concentrated shot-creation responsibility in one primary ball-handler more than Golden State's more distributed roster, combined with a smaller real sample size making any one player's share more extreme
B. `Pr_c` cannot legitimately exceed 100 for any real player, so this value must be an error
C. Golden State simply did not play any clutch minutes that postseason
D. Boston's players were all equally likely to shoot in the clutch, making 189.8 an average value

7. Goldman & Rao (2012) argue that pressure affects NBA players
   asymmetrically. Which combination of real clutch-index values from
   this module's Golden State data would provide direct evidence for
   the "kept trying, got less efficient" half of that asymmetry?

A. A high `Pr_c` alongside a strongly positive `Diff`
B. A high `Pr_c` (Draymond Green's 11.3) alongside a sharply negative `Diff` (Green's -11.7), meaning he shot more often in the clutch even as his efficiency dropped
C. A `Diff` of exactly 0 alongside any `Pr_c` value
D. A negative `Pr_c` alongside a positive `Diff`

8. This module lowers its minimum clutch-attempt threshold (`AS_min`)
   from the textbook's 20 down to 4. What real tradeoff does that lower
   threshold represent?

A. There is no tradeoff; lowering the threshold has no effect on the results
B. A lower threshold includes players with less reliable, noisier clutch samples (as few as 4 total clutch shot attempts) in exchange for having any real player-level comparison at all for a team like Boston, whose smaller real playoffs-only sample would otherwise exclude nearly everyone
C. A lower threshold only affects Golden State's players, not Boston's
D. A lower threshold guarantees every player on both rosters clears it
