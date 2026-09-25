# Module 3 Practice Questions (Ungraded)

These are for your own practice and do not count toward your grade. Try
each one before checking your work in RStudio.

1. A raw table of per-36-minute stats puts makes per 36 minutes,
   turnovers per 36 minutes, and rebounds per 36 minutes side by side.
   What problem does standardizing those variables (converting them to
   z-scores) solve that the raw table does not?

A. It removes the need to use real per-36-minute data
B. It converts every counting stat into a percentage automatically
C. It puts variables measured on completely different scales onto one shared, comparable scale, so their shapes can be compared directly on one chart
D. It makes every number larger so the chart is easier to read

2. Using z = (x - mean(x)) / sd(x), what does a z-score of -1.5 mean
   about a value relative to its group?

A. The value is 1.5 times larger than the group average
B. The value is 1.5 standard deviations below the average of its group
C. The value ranks 1.5th out of every value in the group
D. The value is missing from the dataset

3. In this module's real five-player comparison, Stephen Curry's
   three-point rate z-score is 1.31 and his rebound rate z-score is
   -0.99. Which description best matches that standardized profile?

A. A perimeter-oriented offensive profile: notably above-average three-point rate, notably below-average rebounding
B. A balanced, rebound-and-assist-heavy profile like Russell Westbrook's
C. A two-point and rebounding profile like Giannis Antetokounmpo's
D. A profile with no notable strengths or weaknesses relative to the group

4. NBA analytics leaders including Daryl Morey have raised a specific
   criticism of radar/radial charts. What is it, and why does checking
   the underlying z-score table protect against it?

A. Radar charts cannot display more than three variables at once, so extra variables must be dropped
B. The area enclosed by a radar chart's shape draws the eye even though area is not a meaningful quantity when the axes are unrelated variables on different scales; checking the z-score table keeps you reading the actual numbers instead of the shape
C. Radar charts only work with standardized team data, never player data
D. Radar charts require play-by-play data that `BasketballAnalyzeR` does not provide

5. `barline()` stacks shooting percentages as bars and overlays a
   continuous variable as a line on a second axis. In this module's real
   Houston Rockets example, why is minutes played a reasonable choice
   for that line variable?

A. Minutes played is unrelated to shooting percentage, which makes it a neutral baseline
B. It lets a reader see, in the same view, whether a team's shooting percentages line up with how much a coach actually plays each player, connecting opportunity to performance
C. Minutes played must always be the line variable in `barline()`; no other variable is supported
D. It converts shooting percentages into per-36-minute rates automatically

6. Coefficient of variation is CV = sd(x) / mean(x). Two players have
   the same standard deviation in game-to-game scoring, but one averages
   10 points a game and the other averages 25. Which player has the
   higher CV, and what does that mean?

A. The 25-point scorer, because a larger mean always produces a larger ratio
B. Both players have identical CV, because CV only depends on standard deviation
C. The 10-point scorer, because dividing the same standard deviation by a smaller mean produces a larger ratio, meaning that player is relatively less consistent game to game
D. Neither; CV cannot be compared across players with different scoring averages

7. In the real 2017-18 Houston Rockets data (weighted by shot attempts),
   which shot type had the highest coefficient of variation, and roughly
   how large was it?

A. Three-point percentage, about 6.6%
B. Two-point percentage, about 10.4%
C. Free throw percentage, about 16.2%
D. All three shot types had roughly the same coefficient of variation

8. Assists per game correlate with wins at about 0.25 across the
   2017-18 season, far weaker than net rating's 0.96 correlation from
   Module 2. Which conclusion best fits that comparison?

A. A 0.25 correlation means passing has zero relationship with winning
B. A 0.25 correlation is weak but not zero, so assists per game alone explain only a small part of what separates winning teams from losing ones; net rating captures far more because it accounts for scoring efficiency and defense together
C. Since 0.25 is less than 0.96, assists per game must be measured incorrectly
D. Net rating and assists per game are actually measuring the same thing
