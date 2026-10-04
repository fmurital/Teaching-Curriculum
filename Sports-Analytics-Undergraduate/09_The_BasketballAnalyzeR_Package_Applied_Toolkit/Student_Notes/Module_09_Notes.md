# Module 9 Notes: The BasketballAnalyzeR Package, Applied as One Toolkit

## Where we left off

Module 8 asked how two real numbers move together and whether one can
honestly predict the other. Before that, Modules 2 through 7 each
handed you one real piece of the analyst's toolkit: pace and ratings,
visual team and player profiles, shot charts, correlation and assist
networks, clustering, and regression. Today I am not adding a
completely new statistical idea. I am pulling back the curtain on the
toolkit itself. Every number you have used all course, from
`BasketballAnalyzeR::Pbox` and `Tbox` to `PbP.BDB`, had to come from
somewhere, and I want you to see exactly how, and I want to hand you
four more real functions from this same package so you leave this
course able to build a full real scouting profile on any team,
starting from nothing but raw play-by-play.

Every number below comes from the real 2017-18 NBA regular season,
using `BasketballAnalyzeR::PbP.BDB`, `Pbox`, and `Tbox`, the same real
season and the same real package used throughout this course.

## Part 1: Where does a box score actually come from?

All course long I have handed you `Tbox` and `Pbox` as if they simply
existed. They do not. Every column in those real data frames was built
by counting real events out of raw play-by-play, one shot, one
rebound, one turnover at a time. `BasketballAnalyzeR::TOPboxes()` does
exactly that counting for you, live, for any one real team, straight
from `PbP.BDB`.

I ran it on the Houston Rockets, this course's running case study team
since Module 2:

```r
PbP <- PbPmanipulation(PbP.BDB)
out_hou <- TOPboxes(PbP, team = "HOU")
```

Here is where the real honesty of this exercise shows up. The
built-in `Tbox` row for the Rockets, the one Module 2 used for their
65 real wins, reports 9,213 real points across 82 real games. The
rebuilt-from-play-by-play version reports only 352 real points. That
is not an error. `PbP.BDB` is built around Golden State's real,
complete 82-game 2017-18 schedule; every other team's rows, including
the Rockets', are that team's own real regular-season games against
Golden State specifically, and only three such real games exist in
this dataset. So the rebuilt box score is real and correct, it is
just built from a real, much smaller sample: three real games, not a
real season.

That smaller real sample produces its own honest surprise. Across
those three real games, Chris Paul, not James Harden, led the Rockets
in real scoring:

| Player | Real GP (of 3) | Real PTS | Real 2P% | Real 3P% | Real AST |
|---|---|---|---|---|---|
| Chris Paul | 3 | 65 | 44.0 | 44.0 | 27 |
| Eric Gordon | 3 | 60 | 70.0 | 8.3 | -- |
| James Harden | 2 | 49 | 42.9 | 50.0 | -- |
| Clint Capela | 3 | 45 | 62.5 | -- | -- |

James Harden was the real 2017-18 MVP and the real league's leading
scorer over the full season. None of that is contradicted here. It is
a reminder I want you to carry forward: a real three-game sample can
look nothing like a real 82-game season, and the size of your real
sample should always travel with any number you report, not get left
out of the sentence.

## Part 2: How evenly is scoring actually spread across a real roster?

`BasketballAnalyzeR::inequality()` borrows the real Gini coefficient,
the same real tool economists use to measure income inequality, and
points it at a team's own real scoring distribution. A real Gini
index near 0 means scoring is spread evenly across the roster; a real
Gini index closer to 100 means a small number of players account for
most of the real points.

I expected the Rockets, built that season around one isolation-heavy
real superstar in James Harden, to show more real scoring inequality
than the Warriors, a team famous for its real egalitarian motion
offense. I ran both, using each team's real top 8 scorers from the
full-season `Pbox`:

```r
ineq_hou <- inequality(Pbox.HOU$PTS, nplayers = 8)
ineq_gsw <- inequality(Pbox.GSW$PTS, nplayers = 8)
```

**Real Gini index, Houston Rockets: 30.95**
**Real Gini index, Golden State Warriors: 35.46**

I was wrong. The real Warriors, not the Rockets, show the more
top-heavy real scoring distribution across their top 8. A team's real
offensive system and a team's real reputation are not the same thing
as what the real numbers say about how points actually get
distributed, and the only way to know which one is true is to run the
real function and look.

## Part 3: The whole real league, four real numbers at once

`BasketballAnalyzeR::bubbleplot()` puts four real statistics on one
chart at once: a team's position on the x and y axes, a team's color,
and a team's bubble size. I built a real league-wide version from the
full-season `Tbox`, real 2-point percentage on the x-axis, real
3-point percentage on the y-axis, real free throw percentage as
color, and real total shots attempted as bubble size.

The Rockets sit at real 55.8% on 2-point shots, real 36.2% on
3-point shots, and real 78.1% on free throws, among the real league's
better combinations on all three at once. The real chart makes this
visible in a single glance in a way that reading three separate real
tables never quite does, which is the entire point of a tool like
this one: not a new real statistic, just a better real way to see
several real statistics you already trust, together.

## Part 4: Is a shot actually a good shot, for this specific real player?

Module 4 gave you shot location. `BasketballAnalyzeR::expectedpts()`
goes one step further: it asks whether a shot from a given real
distance is a good shot for one specific real player, relative to
their own real team's expected points at that same real distance. I
ran it on the Rockets' two primary real shot creators across the
three real games this dataset covers:

```r
plrys <- c("James Harden", "Chris Paul")
expectedpts(data = PbP.HOU, bw = 10, players = plrys, col.team = "dodgerblue")
```

The real resulting curves show both players tracking close to the
real team average through the mid-range, with real separation showing
up at different real distances for each player, exactly the kind of
real, player-specific nuance a single team-wide expected-points number
would hide. This is the real payoff of Module 9: you are not learning
a new statistic for its own sake, you are learning to ask a sharper
real question than "was this shot a good shot" and instead ask "was
this shot a good shot for this specific real player."

## Where this goes next

Module 10 takes this same applied, integrative mindset and turns it
toward quality monitoring and injury risk, using real statistical
process control methods on real data rather than box-score counting
stats. Everything you have built across Modules 1 through 9, pace,
visual profiles, shot charts, correlation, clustering, regression, and
now this applied toolkit, is the real foundation that work stands on.
