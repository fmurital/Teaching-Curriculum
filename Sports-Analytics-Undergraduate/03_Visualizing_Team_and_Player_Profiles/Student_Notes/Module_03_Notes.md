# Module 3 Notes: Visualizing Team and Player Profiles

## Where we left off

Module 2 built pace, ratings, and Dean Oliver's Four Factors, and showed
that net rating alone predicts wins better than any single shooting stat
(0.96 versus 0.77 for effective field goal percentage). Those are all
single numbers, one at a time. This module is about a different problem:
how do you look at several numbers about a player or a team at once, and
actually see the shape of what makes them different from someone else?

## Why one number at a time stops working

A player's assist rate on its own tells you almost nothing about whether
they are a distributor, a scorer, or a rebounder, because you have
nothing to compare it to. The moment you want to compare five or six
stats for the same player side by side, on scales that have nothing to
do with each other (makes per 36 minutes versus turnovers per 36
minutes versus rebounds per 36 minutes), a table of raw numbers stops
being readable. Visualizing a profile means putting several variables on
one shared, comparable scale and drawing the shape they make together.

## Standardizing a profile: the z-score

The tool that makes different-scale variables comparable is
standardization. For any variable, the z-score of a value converts it
into "how many standard deviations above or below the average" it is:

```
z = (x - mean(x)) / sd(x)
```

A z-score of 0 means exactly average. A z-score of +1.3 means notably
above average; -1.0 means notably below. Because every standardized
variable now sits on the same scale (centered at 0, with the spread
measured in standard deviations instead of raw units), you can plot
five completely different stats on one chart and compare their shapes
directly. This is exactly what `BasketballAnalyzeR`'s `radialprofile()`
function does by default (`std = TRUE`): it standardizes every column
before drawing the radar chart.

Applied to five real, high-usage 2017-18 players (LeBron James, Stephen
Curry, James Harden, Giannis Antetokounmpo, and Russell Westbrook), on
five per-36-minute rate stats (two-point makes, three-point makes,
rebounds, assists, and turnovers), the standardized profiles make each
player's role visible at a glance. Stephen Curry's three-point rate
stands more than a full standard deviation above this group's average
(z = 1.31) while his rebound rate sits nearly a full standard deviation
below it (z = -0.99). Giannis Antetokounmpo is close to the mirror
image: a strong two-point and rebounding profile (z = 1.00 and 0.90)
with almost no three-point volume (z = -1.05) and the lowest assist rate
in the group (z = -1.49). Russell Westbrook's profile is the most
balanced across all five variables, which matches his real reputation as
a rebound-and-assist-heavy guard.

None of these five players is "better" than another by this chart; the
point of a radial profile is to make each player's statistical identity
visible, not to rank them.

## Reading a profile honestly

Radar charts have real critics inside professional analytics. NBA
analytics leaders including Daryl Morey have argued that radar-style
charts distort perception because the *area* enclosed by the shape draws
the eye, even though area is not a meaningful quantity when the axes are
unrelated variables on different scales. The habit to build here is the
same one from Module 2: a visualization is a tool for reading real data
faster, not a substitute for checking what the numbers actually say.
Before drawing a conclusion from any profile chart, check the actual
z-score or raw value behind whichever "spike" caught your eye.

## Bar-line plots: two kinds of information, one chart

A different profile problem is comparing a categorical breakdown (like
three shooting percentages) against a separate, continuous measure (like
playing time) for the same group of players. `BasketballAnalyzeR`'s
`barline()` function stacks the categorical bars and overlays the
continuous variable as a line on a second axis. Applied to the real
2017-18 Houston Rockets roster (players with at least 500 minutes
played), the chart makes a pattern visible immediately: James Harden and
Chris Paul, the two most-used players by minutes, both shot below 90% on
two-point attempts relative to some bench players, while low-minute
bench players like Tarik Black posted a much higher two-point percentage
on a far smaller, more selective shot diet. Volume and efficiency are two
different things, and a bar-line chart is one way to see both without
building two separate charts.

## Variability: how consistent is a stat, not just what is its average

A shooting percentage is itself an average, and averages hide how spread
out the underlying values are. The coefficient of variation (CV)
measures relative spread: how large the standard deviation is compared
to the mean.

```
CV = sd(x) / mean(x)
```

Because attempt volume differs enormously between a team's stars and its
bench (James Harden attempted 727 two-pointers in 2017-18; Tarik Black
attempted 116), `BasketballAnalyzeR`'s `variability()` function can weight
the calculation by shot attempts, so low-volume shooters do not distort
the result as much as they would in an unweighted calculation. Applied to
the same Houston Rockets roster's two-point, three-point, and free-throw
percentages, weighted by attempts: three-point percentage was the *most*
consistent of the three across these players (CV = 0.066, or about
6.6%), two-point percentage was next (CV = 0.104, about 10.4%), and free
throw percentage was the *least* consistent (CV = 0.162, about 16.2%).
That ordering surprises most people the first time they see it, since
free throws are usually treated as the "easy," low-variance shot in
casual conversation. The real data says free-throw shooting varied more
across this specific roster than three-point shooting did.

## Team profiles: assists, turnovers, and wins

The same profile thinking scales up from players to teams. Comparing
every team's assists per game against its turnovers per game across the
2017-18 season, the five teams that averaged the most assists were the
Golden State Warriors (29.3), Philadelphia 76ers (27.1), New Orleans
Pelicans (26.8), Washington Wizards (25.2), and Denver Nuggets (25.1).
But ball movement alone is a weak predictor of winning: assists per game
correlate with wins at only 0.25, and turnovers per game correlate with
wins at -0.15, both far weaker than net rating's 0.96 from Module 2.
Reading a team's passing profile tells you something about *how* they
play, but not nearly as much about whether that style wins games.

## Why this belongs in the course

This module sits inside the **player performance analysis** throughline:
every technique here (standardized radar profiles, bar-line comparisons,
weighted variability) is a real tool analysts use to describe what a
specific player or team actually does, beyond a single box-score number.
Module 4 moves from these profile visualizations into shot charts and
spatial data, using where on the court a shot happened as the next
variable to visualize.
