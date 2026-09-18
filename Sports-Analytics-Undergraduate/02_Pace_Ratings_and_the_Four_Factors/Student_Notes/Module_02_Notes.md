# Module 2 Notes: Pace, Ratings, and the Four Factors

## Where we left off

Module 1 got everyone's R environment running and made one point repeatedly:
a raw counting stat like points per game only tells you part of the story,
because it doesn't account for how many chances a team actually had to
score. This module fixes that, with three ideas that show up in almost
every advanced basketball stat you will ever see: pace, ratings, and Dean
Oliver's Four Factors.

## Pace: putting every team on the same clock

A team that scores 110 points a game by playing fast is not necessarily a
better offense than a team that scores 105 points a game slowly. Pace
measures how many possessions a team uses per 48 minutes. `BasketballAnalyzeR`
computes this straight from a team's own box score and its opponents' box
score together, because a possession only ends when the ball changes hands
(a make, a defensive rebound, a turnover, or the end of a free throw
trip), and you need both teams' numbers to count that correctly.

Across the 2017-18 NBA season, the league averaged 99.6 possessions per 48
minutes, and even the fastest and slowest teams differed by less than 6
possessions a game (a range of about 97.1 to 102.9). The five fastest teams
that season were the Phoenix Suns, Los Angeles Lakers, New Orleans
Pelicans, Philadelphia 76ers, and Brooklyn Nets. Pace by itself says
nothing about whether a team is good; it just tells you how many
opportunities it created to be good or bad.

## Ratings: points per 100 possessions

Once you know how many possessions a team used, you can ask a fairer
question than "how many points did they score": how many points did they
score *per possession*? Offensive rating (ORtg) and defensive rating
(DRtg) scale this to points per 100 possessions, which is the standard
unit in basketball analytics because it is large enough to read as whole
numbers.

For the 2017-18 season, the five best offenses by ORtg were the Golden
State Warriors, Houston Rockets, Toronto Raptors, Minnesota Timberwolves,
and Cleveland Cavaliers. The five best defenses by DRtg (lowest points
allowed per 100 possessions) were the Boston Celtics, Utah Jazz,
Philadelphia 76ers, San Antonio Spurs, and Toronto Raptors -- notice the
Raptors show up on both lists, which is exactly what you would expect from
a 59-win team.

Net rating (ORtg minus DRtg) turns out to be a far better predictor of
wins than either rating on its own, or than any single shooting stat. In
the real 2017-18 data, a team's effective field goal percentage alone
correlates with its win total at about 0.77. Net rating correlates with
wins at about 0.96. That gap is the whole point of the module: no single
number tells you who wins basketball games, but points scored minus points
allowed, on a per-possession basis, comes close.

## The Four Factors

In *Basketball on Paper* (2004), Dean Oliver broke offensive (and, by
extension, defensive) performance into four factors and proposed rough
weights for how much each one matters: shooting (40%), turnovers (25%),
rebounding (20%), and free throws (15%). `BasketballAnalyzeR`'s
`fourfactors()` function computes all four, for both a team's offense and
its defense, straight from the same two box scores used for pace and
ratings:

- **Effective field goal percentage (eFG%)** -- shooting efficiency,
  adjusted so a three-pointer counts for more than a two-pointer.
- **Turnover rate** -- turnovers as a share of possessions used.
- **Offensive/defensive rebound rate** -- the share of available rebounds
  a team actually grabs.
- **Free throw rate** -- how often a team gets to the free throw line
  relative to its field goal attempts.

Applied to the real 2017-18 data, the offensive factors correlate with
wins in this order: eFG% (0.77), free throw rate (0.40), offensive
rebound rate (0.25), and turnover rate (-0.14, and weaker than Oliver's
25% weight would suggest). That last number is worth sitting with -- it is
a reminder that a framework proposed from one era of data does not have to
reproduce exactly in a different season, and that you should always check
a rule of thumb against the data in front of you rather than repeating it
from memory.

The Houston Rockets, who led the league with 65 wins, illustrate the
factors working together rather than any one of them working alone: an
eFG% of 55.1%, a turnover rate of 13.8%, an offensive rebound rate of
21.3%, and a free throw rate of 23.3%, combined with the league's
second-best offensive rating (112.2) and a merely middle-of-the-pack
defense (103.8). No single factor made that team; the combination did.

## Why this belongs in the course

This module sits inside the **game analysis** throughline: pace, ratings,
and the Four Factors are the standard toolkit analysts inside NBA front
offices and broadcast networks use to describe *why* a team won or lost a
given game or season, rather than just reporting that it did. Module 3
moves from these single-number summaries to actually visualizing team and
player profiles side by side.
