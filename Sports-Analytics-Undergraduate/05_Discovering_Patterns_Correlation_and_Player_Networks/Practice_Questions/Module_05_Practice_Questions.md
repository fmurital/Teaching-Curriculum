# Module 5 Practice Questions (ungraded)

1. Which of the following correctly describes what a correlation
   coefficient close to 1, close to -1, and close to 0 each tell you
   about two variables?

A. Close to 1 means unrelated; close to -1 means strongly related; close to 0 means causally related
B. Close to 1 means the two variables strongly tend to rise and fall together; close to -1 means one tends to rise as the other falls; close to 0 means little to no linear relationship
C. Close to 1 means one variable causes the other; close to -1 means no relationship; close to 0 means a strong relationship
D. All three values mean the same thing: the variables move together

2. This module filters `Pbox` down to the 361 real 2017-18 NBA players
   with at least 500 minutes played before computing per-minute rates
   and correlations, out of 605 total players. Why does that filter
   matter?

A. It does not matter; using all 605 players would produce the same correlations
B. A player with very few real minutes played can post an extreme per-minute rate off a tiny, unstable sample, so leaving low-minute outliers in would distort the real correlation coefficients
C. The filter is only there to make the dataset smaller and faster to load
D. Players with fewer than 500 minutes are not included in `Pbox` at all

3. This module's real correlation between offensive rebounds per minute
   and defensive rebounds per minute is 0.729, the strongest pair in the
   matrix. What is the most likely real basketball reason for this?

A. Offensive rebounds and defensive rebounds are the same statistic recorded twice
B. Both stats depend on the same underlying skill of size, physical strength, and winning position near the basket, not one stat causing the other
C. The correlation is a data error that should be ignored
D. Players who grab offensive rebounds never play any defense

4. This module's real correlation between assists per minute and
   turnovers per minute is 0.687, a strong positive number. Which
   explanation correctly accounts for why a "good" stat and a "bad"
   stat move together here?

A. Turnovers directly cause assists on the following possession
B. High-usage, high-volume ball handlers generate both assists and turnovers together as a byproduct of handling the ball often and taking risks with difficult passes, not because turning the ball over is good
C. The two stats are mathematically identical, so the correlation is meaningless
D. A positive correlation between a good stat and a bad stat is impossible, so this number must be wrong

5. A correlation matrix and an assist network are both tools for
   finding patterns in basketball data, but they answer different
   questions. Which of the following correctly states the difference?

A. There is no real difference; they measure exactly the same thing
B. A correlation matrix shows which statistics move together across a group of players; an assist network shows which specific players create offense for which other specific players on one team
C. A correlation matrix only works for team-level stats, never player stats
D. An assist network only works for players who never turn the ball over

6. In this module's real 2017-18 data, Chris Paul recorded 27 of
   Houston's 67 total real assists across three regular-season games
   against Golden State (about 40%), while LeBron James recorded 12 of
   Cleveland's 38 total real assists across two regular-season games
   against Golden State (about 31.6%), with Houston also getting real,
   substantial assist totals from James Harden and Eric Gordon. Which
   team's real offense looks more like a hub-and-spoke system built
   around one player?

A. Houston, because Chris Paul's raw assist count (27) is higher than LeBron's (12)
B. Cleveland, because LeBron's 31.6% single-player share ran through fewer other real contributors, while Houston's playmaking was shared across Paul, Harden, and Gordon
C. Neither team; both offenses were equally distributed in this sample
D. Both teams, since both had one leading assist player

7. `BasketballAnalyzeR::PbP.BDB` is real play-by-play data built around
   the Golden State Warriors' full 82-game 2017-18 regular season
   schedule. What does that mean for how most other teams, like Houston
   and Cleveland, appear in this dataset?

A. Every team in the dataset has a full 82-game sample, just like Golden State
B. Most other teams appear only in their own real regular-season games against Golden State specifically, which is why Houston's sample is three games and Cleveland's is two, not a full season or a playoff run
C. The dataset only includes games Golden State lost
D. Other teams' games are simulated, not real play-by-play data

8. Using Cleveland's real assist network in this module as the example,
   which of the following describes a genuine real basketball risk of an
   offense that depends heavily on one hub player for playmaking?

A. There is no real risk; a hub-and-spoke offense is always the better structure
B. The offense becomes more exposed if that hub player is off the floor, in foul trouble, injured, or having an off night, since fewer other real players in the sample are built up as high-volume secondary playmakers
C. Hub-and-spoke offenses always produce fewer real turnovers than distributed ones
D. This risk cannot be measured or observed using an assist network
