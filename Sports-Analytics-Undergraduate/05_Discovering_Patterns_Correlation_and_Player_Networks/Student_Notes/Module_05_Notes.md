# Module 5 Notes: Discovering Patterns, Correlation and Player Networks

## Where we left off

Module 4 gave us a new variable, location, and showed that a single
shooting percentage hides where a player actually gets his points.
This module steps back from any one variable and asks a different
question: when I have several box score numbers for the same player,
how do they move together? A player who grabs a lot of offensive
rebounds, does he also block a lot of shots? A player who racks up a
lot of assists, does he also turn the ball over more? Correlation is
the tool for answering exactly that question, and it opens up a
pattern in the data that a single stat, or even a single shot chart,
cannot show on its own.

## Why correlation reveals patterns among box score stats

A correlation coefficient is just a number between -1 and 1 that
tells you how closely two variables move together across a group of
players. Close to 1 means they rise and fall together, close to -1
means one tends to go up when the other goes down, and close to 0
means the two don't tell you much about each other at all. The real
value of this comes when you run it across every pair of stats at
once, since a full correlation matrix lets you scan for the pairs
that are unusually strong and ask why.

I built this module's correlation matrix from real, per-minute rate
statistics for every 2017-18 NBA player who logged at least 500
minutes that season. That filter matters: `BasketballAnalyzeR::Pbox`
holds real box score totals for 605 players who appeared in a 2017-18
NBA game, but a player who only played 40 total minutes can post a
wild per-minute rate off a tiny sample, so restricting to the 361
players with 500 or more minutes keeps the correlation honest. For
each of those 361 players I computed seven real per-minute rates
(points, assists, turnovers, offensive rebounds, defensive rebounds,
steals, and blocks, each divided by minutes played) and ran
`BasketballAnalyzeR::corranalysis()` on the result.

Three real correlations out of that 7-by-7 matrix are worth sitting
with:

- **Offensive and defensive rebounding, 0.729.** This is the
  strongest real correlation in the whole matrix. It makes basketball
  sense once you think about what actually produces a rebound: size,
  positioning near the rim, and physical strength on the glass. A
  player built to grab a defensive rebound is, almost by definition,
  built to grab an offensive one too, since both come from the same
  underlying skill of winning position under the basket. This isn't
  one stat causing the other; it's both stats being driven by the
  same real trait.
- **Assists and turnovers, 0.687.** At first this can look backwards;
  shouldn't a good passer turn the ball over less, not more? The real
  explanation is usage. A player who handles the ball constantly and
  threads difficult, high-value passes into tight windows racks up
  real assists specifically because he's taking those risks, and the
  same ball-handling volume that produces a lot of assists also
  produces more chances for a pass to be picked off or thrown away.
  Point guards who run an offense generate both numbers together;
  players who rarely touch the ball generate neither.
- **Offensive rebounds and blocks, 0.630.** Both of these numbers
  depend on being tall, long, and stationed near the basket rather
  than out on the perimeter. A player chasing blocks is protecting
  the rim, and a player chasing offensive boards is fighting for
  position at the rim, so both stats are really just two different
  readings of the same real thing: how much of a player's game
  happens close to the basket.

None of these three pairs is a coincidence, and none of them proves
that one stat *causes* the other. What they show is that certain box
score numbers cluster together because they're driven by the same
underlying role or skill set on the floor, and once you can see that
clustering in a real correlation matrix, you stop treating each stat
as if it lived in its own separate world.

## A different kind of pattern: who creates offense for whom

A correlation matrix answers "which stats move together." It does not
answer a question that matters just as much to a coach or a scout:
on this specific team, who is actually setting up whom? Two teams can
have similar team-wide assist totals while one team runs its offense
through a single ball-handler and the other spreads playmaking across
four or five players, and a correlation matrix built from season
totals cannot tell the two situations apart. This is where the
assist network comes in. Instead of asking how variables relate to
each other, an assist network asks how *players* relate to each
other, using `BasketballAnalyzeR::assistnet()` to turn every real
assisted basket into a connection between the player who passed and
the player who scored.

## Real assist networks: Houston versus Cleveland

`BasketballAnalyzeR::PbP.BDB` is real, event-level play-by-play data
built around the Golden State Warriors' full 82-game 2017-18 regular
season schedule, and every other team's rows in it are that team's
own real regular-season games against Golden State specifically, not
a playoff series. That gives us two genuinely different real samples
to compare: Houston's three real 2017-18 regular-season games against
Golden State (including the real 2017-18 season opener on October 17,
2017, which Houston won at Golden State 122-121, on the way to a 2-1
real record in this sample), and Cleveland's two real 2017-18
regular-season games against Golden State (including the real,
nationally televised Christmas Day game, which Golden State won
99-92, on the way to a real 2-0 sweep of Cleveland in this sample).

Running `assistnet()` on each team's own real events in these games
produces a strikingly different picture of how the two offenses
actually worked. Houston's playmaking was real and distributed:
Chris Paul led the team with 27 real assists worth 68 real points
created, but James Harden (18 assists, 41 points created) and Eric
Gordon (10 assists, 26 points created) both contributed heavily too,
and Chris Paul's 27 assists made up only about 40% of Houston's 67
total real assists across these three games. Cleveland's playmaking
told the opposite story: LeBron James alone recorded 12 real assists
out of Cleveland's 38 total in this sample, meaning LeBron accounted
for about 31.6% of every single Cleveland assist. Houston ran a
distributed offense with three real playmakers sharing the load;
Cleveland ran a hub-and-spoke offense where the ball, and the
offense's actual creation, ran through one player far more than any
other.

## Why this matters beyond one comparison

This hub-and-spoke-versus-distributed pattern is not just a fun fact
about two real games. It's a genuine window into **player performance
analysis** and **game analysis**: a team whose offense depends this
heavily on one player is more exposed if that player is off the floor,
injured, or simply having an off night, while a team that distributes
playmaking across several real, capable ball-handlers has more paths
to a good possession when any one of them isn't clicking. This is
also a real bridge to how teams get built and paid; a roster
constructed around one true offensive hub carries a very different
kind of real risk, and a very different real salary allocation
problem, than a roster built to distribute playmaking across several
players. The same assist-network method that reveals Houston's and
Cleveland's real offensive structure here is exactly the kind of tool
a front office would use to ask that question about its own team.

## Why this belongs in the course

Correlation and assist networks are two different tools for the same
underlying goal: finding real structure in basketball data that a
single number cannot show on its own. A correlation matrix finds
structure across *stats*; an assist network finds structure across
*players*. Every number in this module, the full 7-by-7 correlation
matrix, both teams' real assist totals and points created, and the
real game-by-game results behind them, is reproducible by running
`Coding_Exercise/module5_correlation_networks.R` against the real,
freely available `Pbox` and `PbP.BDB` datasets.
