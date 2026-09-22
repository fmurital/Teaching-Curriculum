# Module 4 Notes: Season Segments and Final Rankings

## Where we left off

Module 3 split a team's performance by game situation: clutch minutes
against everything else. This module keeps the same basic move,
comparing one real subset of a season against another, but changes
what defines the split. Instead of splitting by time and score within
a game, I am splitting by time across an entire season: the first half
of a team's schedule against the second half. The question this module
asks is simple to state and harder to answer well: does a team's real
performance in the season's first act actually predict how the season
ends, or does the picture change enough between the two acts that an
early read is misleading?

## Why season segments matter

A single full-season rating number flattens a team's whole year into
one line. That is useful for a final standings table, but it hides
real movement. A team can get healthier or more banged up, make a
trade, tighten its rotation, or simply get a softer or harder run of
opponents in one half of the schedule than the other. Zuccolotto,
Manisera & Sandri's Chapter 4 (the "race to the finish") treats a
season as two acts and asks whether a team's segment-1 form is a
reliable preview of its final ranking, or whether the two acts tell
genuinely different stories. That framing matters for anyone building
in-season models: a model trained only on segment-1 data is implicitly
betting that the rest of the season looks like the part already
observed, and this module gives you a real, concrete case where that
bet is only partly safe.

## A methodological note on the data

The textbook's own Chapter 4 example is built from a private 2022-23
Italian Basketball League (LBA) play-by-play file, paired with a
supplementary `AdjRtg()` function that the book distributes only
through its own non-public companion files. Neither is available here.
So, exactly as Module 3 did for the clutch chapter, this module
reproduces the chapter's real methodology on real, freely available
data instead. The `AdjRtg()` function itself is implemented directly
from the textbook's own published formulas (equations 4.1 and 4.2,
which extend Kubatko et al.'s (2007) Offensive and Defensive Rating
concept by adjusting each team's rating for the strength of the
specific opponents it played), applied to real per-game box scores
built the same way Module 3 built them, with `BasketballAnalyzeR`'s own
`TOPboxes()`/`fourfactors()` pipeline, this time run one real game at a
time across an entire season.

The dataset is `BasketballAnalyzeR::PbP.BDB`, and it needs its own
introduction, because it is a different real dataset than the one
Module 3 used. Checking its own `data_set` field and each team's real
game count confirms it is the complete, real 2017-18 NBA regular
season play-by-play record for the Golden State Warriors specifically:
all 82 of GSW's real games, from October 17, 2017 through April 11,
2018, including the real Christmas Day game against Cleveland that
Golden State won 99-92. Every other team in the file appears only in
its own real regular-season games against GSW (two to four games
each), never against each other. That is a genuinely different shape
of data than a normal league season, where every team plays every
other team repeatedly, and it turns out to matter a great deal for
this module's adjusted-rating results, as I get to below. Every number
in this module is real and reproducible by running
`Coding_Exercise/module4_season_segments.R`.

## The two acts of Golden State's real 2017-18 season

Splitting GSW's 82 real games chronologically into a first half
(games 1-41) and a second half (games 42-82) produces two clearly
different real acts. Across the full real season, Golden State went
58-24, with an offensive rating (real points scored per 100 real
possessions) of 112.07 and a defensive rating (real points allowed per
100 real possessions) of 104.39, a net rating of plus 7.68. Split into
segments, the first half was 30-11, with a real offensive rating of
111.89 and a real defensive rating of 102.03, a net rating of plus
9.86. The second half was 28-13, with a real offensive rating of
112.26, essentially unchanged, and a real defensive rating of 106.79, a
real jump of almost five full points. Net rating fell from plus 9.86 to
plus 5.47.

Read those four numbers together and a clear real story emerges:
Golden State's offense held steady across the entire season, but its
defense measurably loosened in the second half, and the team's win
pace slowed slightly along with it, from a 30-11 pace to a 28-13 pace.
None of this means the team collapsed. Both halves are still the
record of a clearly excellent, winning team; this was a 58-win real
regular season played by a team that went on to win the title that
year. But it is a real, measurable within-season shift, exactly the
kind of two-acts pattern this chapter is built to detect, and it shows
up here in real data even though this is a substituted dataset rather
than the textbook's own.

## What "adjusted" rating adds, and how to think about the formula

A plain offensive or defensive rating, the kind computed above, treats
every opponent the same. If a team plays an unusually weak or unusually
strong slate of opponents in one stretch of the season, its plain
rating in that stretch will look better or worse than its "true" level
of play, purely because of who it happened to play. `AdjRtg()` corrects
for that. In words, rather than symbols: for every pair of teams that
played each other, you first compute each team's real scoring rate
against that specific opponent. A team's overall (unadjusted) offensive
rating is the possession-weighted average of those pairwise scoring
rates across all its opponents, and its overall defensive rating is
built the same way from the opponent's side. The adjustment step then
asks, for each opponent a team faced: how much better or worse did this
team actually score against that opponent, compared to what that
opponent's own average defensive rating (built from all of the games
that opponent played) would predict? Averaging that gap across every
opponent a team faced, weighted by possessions, gives the adjusted
offensive rating, `AORtg`. The adjusted defensive rating, `ADRtg`, is
built the same way from the other side: how much better or worse did a
team's defense hold up against each opponent, compared to what that
opponent's own average offensive rating would predict. A team that
padded its raw rating against weak opponents will see its adjusted
rating fall back toward the pack; a team that put up a good raw rating
against a genuinely tough slate will see its adjusted rating hold up or
even rise. This is the same Kubatko et al. (2007) Offensive/Defensive
Rating idea from Module 2 and 3's Four Factors work, with one more
layer: correcting for opponent strength before comparing teams.

## A real, genuinely important finding: GSW's adjusted rating computes to exactly zero

Running `AdjRtg()` on this dataset for Golden State, in the full season
and in both segments separately, produces `AORtg` and `ADRtg` values of
exactly 0.00 every time. Not a small number that rounds to zero. Zero.
The honest, useful thing to do here is not to bury that or wave it away
as noise. It is a real result, it is fully explainable once you look
at why it happens, and the explanation is a genuine lesson about a
kind of failure mode that opponent-adjustment methods can hit.

Here is the mechanism, worked through directly from what `AdjRtg()`
actually computes. Almost every one of GSW's twenty-something real
opponents in this dataset appears in the file only in its own one to
four games, and every one of those games is against GSW. Nobody else
in the file plays that opponent. So when the formula computes that
opponent's defensive rating, the only data feeding into it is exactly
the same games being used to compute GSW's offensive performance
against them. The "opponent's average defense," in other words, is not
an independent, outside benchmark here; for these one-off opponents it
collapses to being identical to how GSW itself scored against them.
Subtracting a number from itself leaves zero, for every single
opponent, and averaging a column of zeros still gives zero. That is
why GSW's `AORtg` and `ADRtg` compute to exactly 0.00 in this dataset,
in every segment.

Now compare that to a team like Portland, which shows up with a real,
non-degenerate `AORtg` of 13.55 in the full-season table. Portland's
only opponent in this dataset is also GSW, so why does Portland's
number not collapse the same way? Because the adjustment for Portland's
performance subtracts GSW's own defensive rating, and GSW's defensive
rating in this file is built from roughly twenty-five to thirty
different real opponents, not just Portland. That really is an
independent, outside benchmark, so Portland's adjusted rating is a
genuine, meaningful number: how much better or worse Portland scored
against GSW than the league-wide average opponent did. The degeneracy
is specific to GSW, because GSW is the one team connected to many
one-off opponents, a "hub and spoke" structure, rather than a genuine
round robin where every team plays every other team repeatedly (which
is exactly what the textbook's own sixteen-team Italian league dataset
looks like, and why the method works cleanly there).

The lesson to take from this is not "adjusted ratings are broken." It
is that a sophisticated statistical adjustment carries an assumption
about how the underlying data is connected, and when that assumption
does not hold, the method can quietly produce a degenerate result that
looks like a real finding rather than an artifact, unless you stop and
ask why a number looks the way it does. A result of exactly zero,
repeated across every segment, is exactly the kind of number that
should make you go check the mechanism rather than report it at face
value.

## A brief for students considering the larger independent project track

*This callout is for anyone thinking about a larger independent
project; it is not core material for the rest of the course.* The
lesson above, that a widely used statistical method can carry a hidden
assumption about the structure of the data it is applied to, and can
quietly fail in a specific, explainable way when that assumption
breaks, is exactly the kind of methodological-rigor question this
course returns to in Module 10's injury-detection thread. There, the
acute:chronic workload ratio is a widely used method in applied sports
science that carries its own documented statistical problems under
certain real conditions (mathematical coupling between the acute and
chronic windows, arbitrary window-length choices, inconclusive
randomized-trial evidence). If you found the GSW degeneracy above
interesting, that is the same kind of question, applied to a different
method and a different sport-science context, and it is a genuine
methodological bridge worth exploring once we reach Module 10.

## Reading the real CART tree and alluvial figure

The other twenty-some real teams in this dataset, each with only two to
four real games, still produce genuine, non-degenerate adjusted ratings
in their first-half segment, since their opponent pool composition
differs from GSW's. Fitting a real classification and regression tree
(`rpart`) on these teams' real segment-1 `AORtg1` and `ADRtg1` values,
predicting each team's real number of wins recorded in this sample,
produces a first split on `AORtg1 < -0.015`: essentially, teams whose
real segment-1 adjusted offensive rating was positive tended to record
more real wins in this sample than teams whose segment-1 adjusted
offensive rating was negative. Treat this the way the textbook itself
treats CART in this chapter: as an exploratory, data-driven way to find
a natural split in the data, not as a rigorously validated predictive
model. With most teams contributing only two to four real games, this
tree is a demonstration of the method on a small, real, honestly
noisy sample, not a claim about what predicts winning basketball in
general.

`Coding_Exercise/module4_alluvial.png` shows the same idea as a real
alluvial (Sankey-style) diagram, in the spirit of the textbook's own
Figure 4.3: each team's segment-1 `AORtg1` category (above or below the
real median) flows into its segment-1 `ADRtg1` category, which flows
into the team itself, with the width of each ribbon scaled by real
wins recorded in this sample. It is a genuinely useful way to see, at a
glance, which combination of segment-1 offensive and defensive
adjusted rating tended to travel with more real wins in this specific,
small dataset, without pretending the sample is large enough to settle
the question.

## Why this belongs in the course

This module extends the situational-splitting logic from Modules 2 and
3 across an entire season rather than within a single game, and it adds
a genuinely important methodological skill: recognizing when a
sophisticated adjustment technique's assumptions do not match the data
it has been handed, rather than reporting a strange number at face
value. Every number in this module, the two real season segments'
ratings, the real adjusted-rating degeneracy, and the real CART split,
is reproducible by running `Coding_Exercise/module4_season_segments.R`
against the real, public `PbP.BDB` dataset.
