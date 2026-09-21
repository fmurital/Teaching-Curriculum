# Module 4 Notes: Shot Charts and Spatial Data

## Where we left off

Module 3 was about comparing several numbers for a player or a team at
once, standardized onto one shared scale. This module adds a variable
we have not used yet: location. Every shot in a basketball game happens
somewhere specific on the floor, and once you can see where a shot came
from, you can ask a much sharper question than "how efficient is this
player." You can ask "efficient from where."

## Why location is its own variable

A shooting percentage on its own hides a huge amount of information
about shot difficulty. A player who shoots 45% overall could be a
mediocre three-point shooter carried by a great inside game, or an
elite three-point shooter who forces up a few bad long twos, and a
single number cannot tell the two apart. Spatial data, the x and y
coordinates recorded for every shot attempt, lets you break scoring
efficiency apart by location instead of averaging it all together.

## Real shot coordinates, real games

Every chart and number in this module comes from real play-by-play
data: `BasketballAnalyzeR::PbP.BDB`, which records every event from the
2017-18 NBA playoffs, 82 real games, shot by shot, with the exact x-y
coordinates of where the ball left the shooter's hands. After running
`PbPmanipulation()` to clean the data, `BasketballAnalyzeR`'s
`shotchart()` function draws the shot directly on a scale basketball
court, and it takes coordinates centered on the basket rather than on
the corner of the court, so a shot chart is really nothing more than a
scatterplot with a court drawn behind it.

## Reading a real shot chart

Look at the Houston Rockets' 273 real field-goal attempts across their
2018 playoff run. The made shots (in one color) and missed shots (in
another) cluster in two places: tight around the rim, and along the
three-point arc. There is almost nothing in between. That gap in the
middle of the chart is not an accident, and it is not unique to Houston
in 2018. Across all 14,354 real field-goal attempts in the entire 2018
playoffs, shots from 15-21 feet (the "long two") made up only 14.8% of
all attempts leaguewide, the smallest share of any of the four zones
this module uses.

## Zones: turning a scatter of dots into a comparison

To compare shot selection across teams and players, this module splits
the court into four real distance zones, computed directly from each
shot's `shot_distance` value: the rim (0-4 feet), short/mid range (5-14
feet), the long two (15-21 feet), and the three-point shot (22+ feet).
For each zone you can compute two different things: field goal
percentage (how often shots from that zone go in) and points per shot
(how many points, on average, one attempt from that zone is worth,
accounting for makes, misses, and the extra point a three is worth).
Leaguewide across the real 2018 playoffs: the rim converted at 64.4%,
short/mid at 41.8%, the long two at 41.7%, and the three at 37.5%. The
rim and the three are both worth taking specifically because of how
often they go in or how much they pay off when they do; the long two is
the worst of both worlds; a lower percentage than the rim and no extra
point for the trouble, the way a three-pointer gets.

## Two real teams, two real shot profiles

The Houston Rockets and Cleveland Cavaliers met in the 2018 Eastern and
Western playoff fields that same postseason. Their real shot zone
profiles are strikingly different. Houston attempted 47.6% of its shots
from three and only 6.2% from the long two; 82.2% of every Rockets shot
in these data came from the rim or from three. Cleveland's profile was
far less concentrated: 37.4% from three, but a real 22.5% from
short/mid range and 11.5% from the long two, for a combined 34% of
shots from the two least valuable zones by points per shot. This is not
a coincidence. Houston's front office, led by general manager Daryl
Morey, built the roster and the offense specifically around taking only
the shots with the best real expected value: shots at the rim and
three-pointers, while avoiding the long two whenever a better option
existed. Reporters and fans nicknamed this shot-selection philosophy
"Moreyball." The real 2018 playoff data in this module's shot charts is
direct, first-hand evidence of that strategy on the floor, not just a
description of it.

## Reading one player's floor: Harden and LeBron

The same zone breakdown works at the player level. James Harden's real
39 shot attempts against Cleveland split 46.2% from three (50% shooting
on those threes) and only 7.7% from the long two. LeBron James's 36
real attempts against Houston told a different story: 44.4% came at the
rim, where he shot an extraordinary 87.5%, with a smaller 27.8% share
from three (only 20% shooting on those, a real cold stretch in this
sample). Neither player's overall shooting percentage alone (46.2% for
Harden, 52.8% for LeBron in this data) tells you this. The shot chart
and the zone table do.

## Reading a shot chart honestly

A shot chart is a visualization, and Module 2 and Module 3 both taught
the same underlying habit: check the real number behind a shape before
trusting it. A shot chart with a lot of dots concentrated at the rim
looks impressive, but a cluster of makes near the basket from a small
number of total attempts is a different story than the same cluster
built on hundreds of shots across a full season. Always check the
attempt count (and, ideally, the percentage) behind any visually
striking cluster before drawing a conclusion from a shot chart alone.

## Why this belongs in the course

This module sits inside the **positioning and shifting** throughline:
shot location is the most direct, literal form of positioning data in
box-score-adjacent basketball analytics, and it is the foundation every
later spatial technique in this course builds on. Module 6 returns to
this same coordinate data to study event density and shooting under
defensive pressure; Module 8 uses shot location again to build
regression models of scoring. Every number and chart in this module
comes directly from `Coding_Exercise/module4_shot_charts.R`, reproducible
by anyone who runs the script against the real, freely available
`PbP.BDB` dataset.
