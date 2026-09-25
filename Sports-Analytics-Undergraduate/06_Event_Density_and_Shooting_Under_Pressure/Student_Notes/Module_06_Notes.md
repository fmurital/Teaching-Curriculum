# Module 6 Notes: Event Density and Shooting Under Pressure

## Where we left off

Module 5 asked how box score stats and players relate to each other,
using correlation matrices and assist networks built from season-long
totals. Those tools are powerful, but they both flatten time out of
the picture. A player's assist total treats his first assist of the
season the same as his last, and a correlation coefficient treats a
January jump shot the same as a Game 7 jump shot. This module puts
time back in. I want you to see not just what a player did, but
when, and whether when a shot happens changes how likely it is to go
in.

## Event density: where the action actually piles up

A density plot is a way of asking "when do most events happen,"
smoothed into a curve instead of a jagged histogram. `BasketballAnalyzeR::densityplot()`
takes real play-by-play events and a time variable and shows you
exactly that. I used it on `playlength`, which is the real number of
seconds elapsed in the current possession when an event was logged,
across every real field goal attempt in `BasketballAnalyzeR::PbP.BDB`
(the real 2017-18 NBA play-by-play data built around the Golden State
Warriors' full 82-game schedule; every other team's rows in this
dataset are that team's own real regular-season games against Golden
State specifically). Across 14,355 real field goal attempts,
`playlength` ranges from 0 to 46 seconds, with a median of 11 and a
mean of 11.3. That distribution is not flat. Shot attempts cluster
early in a possession, thin out through the middle of the shot clock,
and then show a second smaller bump right before a possession has to
end. That second bump is what this module is really about: shots
taken because the clock is forcing the issue, not because the offense
found the shot it wanted.

## Turning "late in the clock" into a real, testable claim

A density plot shows you where events pile up, but it does not, by
itself, tell you whether a shot taken late in the clock is a worse
shot. To answer that I split every real field goal attempt into three
buckets by `playlength`: early clock (under 12 seconds elapsed), mid
clock (12 to 17 seconds), and late clock (18 seconds or more elapsed,
meaning the shot clock has 6 seconds or less remaining). Real,
computed shooting percentage in each bucket:

| Shot-clock bucket | Real attempts | Real makes | Real FG% |
|---|---|---|---|
| Early clock (under 12s elapsed) | 7,346 | 3,643 | 49.6% |
| Mid clock (12-17s elapsed) | 4,157 | 1,952 | 47.0% |
| Late clock, high pressure (18s+ elapsed) | 2,852 | 1,210 | 42.4% |

That is a real 7.2 percentage point drop in field goal percentage
between the earliest and latest shot-clock buckets, computed directly
from `result == "made"` on every real attempt. Three-point shooting
specifically tells a slightly different, more interesting story:

| Shot-clock bucket | Real 3P attempts | Real makes | Real 3P% |
|---|---|---|---|
| Early clock (under 12s elapsed) | 2,542 | 943 | 37.1% |
| Mid clock (12-17s elapsed) | 1,300 | 529 | 40.7% |
| Late clock, high pressure (18s+ elapsed) | 918 | 307 | 33.4% |

Three-point shooting is not simply worst late; it's actually best in
the middle of the clock and worst at both extremes. Early three-point
shots include a lot of quick, semi-contested transition looks before
an offense has set up, while late-clock threes are frequently the
last, most desperate option available when nothing else has worked.
Reading a real number honestly means noticing when it does not fit
the simple story you expected.

## A second kind of pressure: clutch time

Shot-clock pressure is about the shooter running out of time inside
one possession. Clutch-time pressure is about the entire game running
out of time. I used the standard definition NBA.com's own advanced
stats use for clutch time: the last five minutes of the fourth period
or overtime, with the score within five points. In `PbP.BDB`'s real
event data, `periodTime` is the real number of seconds elapsed in the
current period, so the last five minutes of a 12-minute period is
`periodTime >= 420`. Applying `period >= 4 & periodTime >= 420 &
abs(home_score - away_score) <= 5` to every real field goal attempt in
the dataset gives:

| Situation | Real attempts | Real makes | Real FG% |
|---|---|---|---|
| Non-clutch | 14,007 | 6,660 | 47.5% |
| Clutch (last 5 min, margin within 5) | 348 | 145 | 41.7% |

A real 5.8 percentage point drop in shooting under real clutch
conditions, computed the same way as every other number in this
module: `result == "made"` on real, filtered play-by-play rows. That
gap is smaller than the shot-clock gap, but it is not nothing, and it
is worth sitting with why. Clutch shots are not just contested by a
ticking clock; they are contested by a defense that knows exactly
which player is about to get the ball and is allowed to load up
against them specifically, because the offense has fewer possessions
left to disguise its intentions.

## Who actually takes the real clutch shots

Because `PbP.BDB` is centered on Golden State's real 2017-18 schedule,
the players with enough real clutch attempts to matter are mostly
Warriors and the opponents they played close games against. Among
players with at least 5 real clutch attempts in this sample, Kevin
Durant led with 42 real clutch attempts (20 makes, 47.6%), followed by
Klay Thompson (28 attempts, 32.1%), Stephen Curry (27 attempts, 40.7%),
and Draymond Green (23 attempts, 30.4%). Notice that even for a team
this talented, real clutch shooting percentages sit well below what
those same players shoot for the season overall. Volume in the clutch
is its own signal, separate from efficiency: it tells you who a
coaching staff actually trusts with the ball when the game is on the
line, whether or not that trust pays off on any single possession.

## Why this belongs in the course

Event density and pressure splits are two different lenses for the
same underlying idea: a shot is not just a shot. Where it happens in
the shot clock and where it happens in the game changes both how hard
it is and, often, how the box score alone would make you misjudge a
player's shooting. This is real **game analysis** and **player
performance analysis**: a player's raw shooting percentage can hide
whether he is getting easy, unpressured looks or whether he is the
one repeatedly asked to bail out a possession as the clock expires.
Every number in this module, both shot-clock buckets, the clutch-time
split, and the real player-level clutch attempts table, is
reproducible by running `Coding_Exercise/module6_event_density_pressure.R`
against the real, freely available `PbP.BDB` dataset.
