# Module 5 Practice Questions (ungraded)

1. In your own words, explain what a correlation coefficient close to
   1, a coefficient close to -1, and a coefficient close to 0 each
   tell you about two variables.

2. This module filters `Pbox` to the 361 real 2017-18 NBA players with
   at least 500 minutes played before computing per-minute rates and
   correlations. Why does that filter matter, and what could go wrong
   if you skipped it and used all 605 players instead?

3. The real correlation between offensive rebounds per minute and
   defensive rebounds per minute is 0.729, the strongest in this
   module's matrix. Explain, using a real basketball reason and not
   just the number itself, why these two stats move together so
   closely.

4. The real correlation between assists per minute and turnovers per
   minute is 0.687. Explain why a strong positive correlation here
   does not mean turnovers are good, or that a coach should want a
   player to turn the ball over more.

5. A correlation matrix and an assist network are both tools for
   finding "patterns" in basketball data, but they answer different
   questions. In one or two sentences, explain the difference between
   what each one actually measures.

6. In this module's real data, Chris Paul's 27 real assists made up
   about 40% of Houston's 67 total real assists across three real
   2017-18 regular-season games against Golden State, while LeBron
   James's 12 real assists made up about 31.6% of Cleveland's 38 total
   real assists across two real 2017-18 regular-season games against
   Golden State. Which team's real offense looks more distributed
   across multiple playmakers, and which looks more like a hub and
   spoke built around one player?

7. `BasketballAnalyzeR::PbP.BDB` is real play-by-play data built around
   the Golden State Warriors' full 82-game 2017-18 regular season
   schedule. Why does that mean most other teams only appear in this
   dataset for a small number of real games, and why is it important
   to say clearly that these are regular-season games against Golden
   State specifically, rather than describing them as a playoff run?

8. Describe one real basketball risk a team faces if its offense
   depends heavily on a single hub player for playmaking, using
   Cleveland's real assist network in this module as your example.
