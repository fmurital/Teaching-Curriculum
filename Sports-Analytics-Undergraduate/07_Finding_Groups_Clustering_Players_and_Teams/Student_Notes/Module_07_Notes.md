# Module 7 Notes: Finding Groups, Clustering Players and Teams

## Where we left off

Module 6 asked whether a shot's timing changes how likely it is to go
in, and found that it does: real field goal percentage fell from
49.6% early in the shot clock to 42.4% late, and real clutch-time
shooting fell to 41.7% from a non-clutch 47.5%. That module was about
a single player in a single moment. This module zooms all the way
out. Instead of asking what happens to one shot, I want to ask what
kind of player, and what kind of team, are actually out there in the
league this season, and whether the labels we already use ("point
guard," "stretch four," "three-and-D wing") hold up once I let the
real data group players for itself instead of relying on a position
label printed on a roster.

## Why clustering, and why standardize first

Clustering does not know what a "shooting guard" is. All it can do
is take a set of numeric variables, measure how far apart every pair
of players sits in that numeric space, and group together whoever
sits close. `BasketballAnalyzeR::hclustering()` and
`BasketballAnalyzeR::kclustering()` both do this, using two different
strategies: hierarchical clustering builds the groups from the bottom
up, merging the two closest players or clusters at each step until
everyone belongs to one final group, while k-means clustering starts
by guessing k center points and repeatedly reassigns every player to
the nearest center. Both functions standardize every column first
(subtracting the mean, dividing by the standard deviation), because
without that step a variable measured in bigger raw numbers, like
points, would dominate a variable measured in smaller raw numbers,
like blocks, for no basketball reason at all. Every number in this
module comes from real 2017-18 season data in `BasketballAnalyzeR::Pbox`
(605 real players) and `BasketballAnalyzeR::Tbox` and `Obox` (30 real
teams), the same real season used in Modules 1, 2, 5, and 6.

## Grouping real players: how many groups actually make sense

I started with the 183 real players who logged at least 1,500 real
minutes in the 2017-18 season, using eight real per-player box score
totals: points, three-pointers made, total rebounds, assists,
turnovers, steals, blocks, and personal fouls. Before picking a
number of clusters, I let `hclustering()` compute the real
"variance between" clusters (how much of the total spread in the
data is explained) at every value of k from 1 to 10:

| k | Real variance explained | Real gain from previous k |
|---|---|---|
| 2 | 20.8% | +20.8 |
| 3 | 38.7% | +17.8 |
| 4 | 43.2% | +4.6 |
| 5 | 49.1% | +5.8 |
| 6 | 53.2% | +4.1 |
| 7 | 55.6% | +2.4 |
| 8 | 58.2% | +2.6 |
| 9 | 62.3% | +4.2 |
| 10 | 64.3% | +1.9 |

The real jump from k=2 to k=3 is enormous, and every step after k=3
adds much less. I chose k=7 because the gain from adding a seventh
group (+2.4 percentage points) is the smallest gain up to that point,
a real sign of diminishing returns, and because seven groups is
exactly what `BasketballAnalyzeR`'s own documented example uses on
this same kind of player data. Picking k is a judgment call informed
by the real numbers, not a fixed rule, and I want you to see me make
that judgment call out loud rather than pretend the "right" k was
obvious from the start.

## Seven real groups of players, in plain language

Running `hclustering(Xp, labels = IDp, k = 7)` on the real, standardized
data produced seven real groups, ranging from 15 to 43 players.
Reading each group's real average profile (all values are standard
deviations above or below the league average for this 183-player
set):

- **Cluster 1 (28 real players): primary ball-handling engines.**
  Well above average in points (+1.32), assists (+1.44), and steals
  (+1.09), with high turnovers too (+1.40), which tracks with how
  much of the offense runs through their hands. Real members include
  LeBron James, James Harden, Chris Paul, Russell Westbrook, and
  Damian Lillard.
- **Cluster 2 (29 real players): secondary playmakers.** Modestly
  above average in assists (+0.52) but below average in scoring,
  rebounding, and shot blocking. Real complementary guards who
  facilitate without being the first offensive option.
- **Cluster 3 (19 real players): rim-protecting bigs.** Far below
  average in three-pointers made (-1.11), above average in rebounding
  (+0.76), and far above average in blocks (+1.34). Rudy Gobert is a
  real member of this group.
- **Cluster 4 (33 real players): balanced, moderate role players.**
  This is the single most homogeneous real cluster (CHI = 0.30, the
  lowest of all seven), sitting close to league average across almost
  every category. Real depth-chart contributors who do a little of
  everything without excelling at any one thing.
- **Cluster 5 (43 real players): perimeter shooting wings.** The
  largest real cluster, above average in three-pointers made (+0.72)
  and below average in turnovers, matching a lower-usage,
  catch-and-shoot offensive role. Stephen Curry is a real member of
  this cluster, which says something honest about how a standardized,
  team-relative profile can place an elite shooter alongside players
  who take far fewer shots overall.
- **Cluster 6 (16 real players): versatile do-everything forwards.**
  This is the single most varied real cluster (CHI = 0.95, the
  highest of all seven): above average in points, rebounds, assists,
  and blocks all at once. Real members include Kevin Durant, Draymond
  Green, Giannis Antetokounmpo, and Anthony Davis, exactly the kind of
  positionless, do-everything player the modern league prizes.
- **Cluster 7 (15 real players): limited-role bench players.** Below
  average in every single category, and the most uniform real cluster
  after Cluster 4 (CHI = 0.19). Real rotation players who log real
  minutes but do not put up much of a statistical footprint in any
  category.

`CHI` (cluster heterogeneity index) measures how spread out the
players inside one cluster still are. A cluster near 0.9 to 1.0, like
Cluster 6, groups together real stars who all happen to be
statistically versatile but are not all identical to each other. A
cluster near 0.2 to 0.3, like Cluster 7 or Cluster 4, groups together
players who genuinely look alike in the real data.

## Does a second method agree? Real hierarchical clustering vs. real k-means

I ran `kclustering()` on the exact same real 183-player data, also
with k=7, and cross-tabulated the two real sets of cluster
assignments against each other. If I take, for every hierarchical
cluster, the k-means cluster that captures the largest share of its
real members, that modal k-means cluster accounts for 124 of the 183
real players, about 67.8%. The most distinctive real groups agree the
most: Cluster 3 (rim protectors) and Cluster 7 (limited-role bench
players) each have around 90% of their real members land in a single
matching k-means group. The least distinctive groups agree the least:
Cluster 5 (perimeter shooters) only has about 51% of its real members
land in one matching k-means group, with real players splitting
across three different k-means clusters instead. That is not a
failure of either method. It is a real, honest finding: two different
clustering algorithms agree strongly on players with a clear,
distinctive statistical identity and agree far less on players
sitting in the fuzzy middle ground between roles.

## A 2D map of real player similarity

`MDSmap()` compresses the same eight-variable, 183-player real
dataset down to two dimensions I can actually plot, placing players
who look alike in the real data close together on the page. The real
stress index (a measure of how much distortion this compression
introduces) came out to 13.9%, a reasonable but imperfect fit; some
real distance relationships get compressed or stretched to fit two
dimensions. Even so, the real map groups Russell Westbrook, LeBron
James, and James Harden together at one edge, and groups the tallest
real rim-protecting centers, Rudy Gobert, DeAndre Jordan, Andre
Drummond, and Dwight Howard, together at another. This is the same
underlying structure the hierarchical and k-means clusters already
found, just laid out visually instead of assigned to numbered groups.

## Clustering real teams, not just real players

The same tools work on real teams. Using each real team's Four
Factors profile from `fourfactors(Tbox, Obox)` (the same function
from Module 2: offensive and defensive rating, effective field goal
percentage, turnover rate, rebound rate, and free throw rate, for and
against), I ran `hclustering()` on all 30 real 2017-18 teams and
picked k=5 real clusters:

| Cluster | Real teams | Real identity | Mean real wins | Real win range |
|---|---|---|---|---|
| 1 | 7 | Weak offense and defense across the board | 26.3 | 21-35 |
| 2 | 9 | Strong defense, an average offense | 49.0 | 39-59 |
| 3 | 6 | Elite, efficient shooting offense | 50.5 | 36-65 |
| 4 | 3 | Severely offense-limited | 26.0 | 24-27 |
| 5 | 5 | High rebounding and ball-hawking identity | 44.8 | 42-48 |

Real Cluster 3, the elite-shooting-offense group, contains the 2017-18
Houston Rockets (65 real wins) and Golden State Warriors (58 real
wins), the two teams that met in that year's Western Conference
Finals, alongside the Cleveland Cavaliers, New Orleans Pelicans,
Denver Nuggets, and Charlotte Hornets. Real Cluster 1 and real Cluster
4 both cluster around a mean win total in the mid-20s, but for
different real statistical reasons: Cluster 1 is weak across both ends
of the floor, while Cluster 4 (the Chicago Bulls, Dallas Mavericks,
and Sacramento Kings, three teams in the middle of real rebuilding
efforts that season) is specifically, severely offense-limited, more
than two standard deviations below the league in effective field goal
percentage and free throw rate. Two teams can lose the same number of
real games for genuinely different real reasons, and clustering the
underlying factors, not just the win total, is how you tell those
reasons apart.

## Why this belongs in the course

Clustering is real **player performance analysis** and real **game
analysis** at the same time: it takes the individual, descriptive
numbers this course has spent six modules computing and asks what
natural groups actually exist inside them, without starting from a
label a roster page already assigned. It also connects directly to
positioning and lineup construction: a front office deciding whether
two players duplicate each other's role, or deciding what kind of
player a roster is missing, is implicitly asking a clustering
question, whether or not they run the actual algorithm. Every number
in this module, the real variance-explained tables, the real seven
player clusters and five team clusters, the real cross-tabulation
between hierarchical and k-means results, and the real MDS map, is
reproducible by running
`Coding_Exercise/module7_clustering_players_and_teams.R` against the
real, freely available `Pbox`, `Tbox`, and `Obox` datasets.
