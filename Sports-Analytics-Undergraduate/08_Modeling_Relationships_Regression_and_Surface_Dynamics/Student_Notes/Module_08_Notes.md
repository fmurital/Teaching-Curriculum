# Module 8 Notes: Modeling Relationships, Regression and Surface Area Dynamics

## Where we left off

Module 7 asked what kind of player and team actually exist in the
league, and let real clustering answer that question instead of
trusting a position label on a roster. That module grouped players
and teams by shape. This module asks a different kind of question.
Instead of "what groups exist," I want to ask "how do two real
numbers move together, and can I use one to honestly predict the
other." Every number below comes from the real 2017-18 NBA regular
season in `BasketballAnalyzeR::Pbox` (605 real players) and
`BasketballAnalyzeR::Tbox` and `Obox` (30 real teams), the same real
season used throughout this course.

## Part 1: Does a team's Net Rating really predict its wins?

Net Rating is just offensive rating minus defensive rating, points
scored per hundred possessions minus points allowed per hundred
possessions. I built it here from the real Four Factors output I
already used in Module 2 and Module 7. Here is what the real top and
bottom of the league looked like in 2017-18:

| Team | Real Net Rating | Real Wins |
|---|---|---|
| Houston Rockets | +8.47 | 65 |
| Golden State Warriors | +8.04 | 58 |
| Toronto Raptors | +7.60 | 59 |
| Philadelphia 76ers | +5.44 | 52 |
| Utah Jazz | +4.62 | 48 |
| Atlanta Hawks | -5.79 | 24 |
| Memphis Grizzlies | -6.58 | 22 |
| Chicago Bulls | -7.81 | 27 |
| Sacramento Kings | -7.83 | 27 |
| Phoenix Suns | -9.71 | 21 |

I fit a real simple linear regression, `Wins ~ Net Rating`, using
`BasketballAnalyzeR::simplereg()`. The real fitted line came out to:

**Wins = 40.998 + 2.444 x Net Rating**

with a real R-squared of 0.9133. That means 91.3% of the real
variation in how many games a 2017-18 team won is explained by one
single number, its point differential per hundred possessions. The
Houston Rockets, the real league's best Net Rating team that season
(+8.47), also won the most real games (65). The Phoenix Suns, the
real league's worst Net Rating team (-9.71), won the fewest (21).
That is not a coincidence built into the data; it is what a strong
real linear relationship looks like.

## A closer look at the fit: does a straight line undersell it?

I also fit a real local polynomial (degree 2) version of the same
relationship using the same `simplereg()` function with `type =
"pol"`. That real curved fit raised R-squared slightly, to 0.9527.
The improvement is real but modest, which tells me the true
relationship between Net Rating and Wins is close to a straight line
across most of the league, with only a small amount of real curvature
at the extremes. I want you to see both fits before deciding for
yourself whether the extra complexity of a curve is worth it here,
which is exactly the kind of judgment call real analysts have to make
constantly.

## Part 2: Assists and turnovers, a real relationship worth being careful about

Not every real relationship in basketball is as clean as Net Rating
and Wins. I looked at real assists per minute against real turnovers
per minute, for every real 2017-18 rotation player with at least 500
real minutes played (361 of the league's 605 real players). The real
fitted line:

**Turnovers per minute = 0.031 + 0.255 x Assists per minute**

with a real R-squared of only 0.4725. Less than half of the real
variation in a player's turnover rate is explained by how often they
assist. That is still a real, meaningful relationship (more
playmaking responsibility does come with more turnover risk, on
average), but it leaves plenty of room for a player to defy it. Look
at these real 2017-18 point guards:

| Player | Real AST per min | Real TOV per min |
|---|---|---|
| Russell Westbrook | 0.281 | 0.131 |
| John Wall | 0.279 | 0.112 |
| Chris Paul | 0.247 | 0.069 |
| James Harden | 0.247 | 0.124 |
| Ben Simmons | 0.242 | 0.102 |
| Stephen Curry | 0.190 | 0.094 |
| Damian Lillard | 0.180 | 0.077 |
| Kyrie Irving | 0.159 | 0.073 |

Chris Paul and James Harden had almost identical real assist rates
(0.247), but Chris Paul's real turnover rate was nearly half of
Harden's. That gap is exactly what a real R-squared of 0.4725 is
telling you: assists predict turnovers on average, but a single
player's own decision-making can pull them well off the real fitted
line in either direction. A regression line is a real summary of a
relationship, not a promise about any one player.

## Part 3: Surface area dynamics, real variability as area

The BasketballAnalyzeR::variability() function builds a chart where
each variable becomes a bubble, and the real size, the real area, of
that bubble is its real weighted standard deviation. That is where
this module's title comes from: I am not just looking at a single
number's spread, I am looking at it as a real visual surface. I ran
this on the real 2017-18 Houston Rockets rotation (12 players, MIN >=
500), weighting each shooting percentage by real shot volume:

| Shooting split | Real weighted SD (Rockets) | Real weighted SD (league) |
|---|---|---|
| Two-point percentage | 5.81 | 5.53 |
| Three-point percentage | 2.41 | 4.46 |
| Free throw percentage | 12.64 | 9.52 |

Free throw percentage produced the real largest bubble on both the
Rockets and the league-wide version of this chart. That makes real
basketball sense. Two-point and three-point shots are contested,
defended, and often set up by a play design, which compresses how
much a shooter's percentage can drift from teammate to teammate.
A free throw is unguarded and entirely about individual mechanics and
repetition, so it is real, honest room for a much wider real spread,
from Tarik Black's real 46.0% to Joe Johnson's real 95.2% on the same
2017-18 Rockets roster. Notice the one place the Rockets differ from
the league: their real three-point spread (2.41) was tighter than the
league's (4.46), which lines up with how deliberately that specific
roster was built around three-point shooting.

## Part 4: A real correlation network among per-minute stats

Finally, I ran `BasketballAnalyzeR::corranalysis()` on eight real
per-minute box score rates (points, three-pointers made, two-pointers
made, rebounds, assists, turnovers, steals, blocks) across the same
361 real rotation players, thresholding out anything weaker than
0.5 in absolute value. A few real relationships survived that
threshold and are worth discussing directly: assists and turnovers
correlated at a real 0.687, the strongest real off-diagonal pair in
the whole matrix, confirming Part 2's story at the league level, not
just for eight point guards. Rebounds and blocks correlated at a real
0.640, the real fingerprint of a big man's game. Three-pointers made
correlated negatively with both rebounds (-0.518) and blocks (-0.469),
a real, honest statistical picture of the league sorting itself into
two different kinds of players by role.

## Where this goes next

Module 9 puts everything from Modules 1 through 8, pace, ratings,
visual profiles, shot charts, correlation, event density, clustering,
and now regression and variability, into the same applied toolkit, so
you can move between all of these real techniques inside one real
analytics workflow instead of treating each one as a standalone
exercise.
