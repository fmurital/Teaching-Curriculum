# Module 5 Notes: Understanding Players' Spatial Dynamics

## Where we left off

Module 4 compared one real slice of a season against another, first
half versus second half, and found that a team's early form is only a
partial preview of how its season ends. Every module up to this point
has treated a player or a team as a set of numbers: a rating, a
correlation, a rank. This module changes the unit of analysis. Instead
of asking what a player's stats say, I want you to ask a more literal
question: where on the court does a player actually operate, and how
does that spatial footprint differ from a teammate's?

## A methodological note on the data

Zuccolotto, Manisera & Sandri's Chapter 5 builds its animated plots,
Voronoi tessellations, and speed/acceleration figures from proprietary
frame-by-frame optical player-tracking data, the kind of data the NBA
itself collects through camera systems (Second Spectrum historically,
Sony's Hawk-Eye system more recently) that record every player's court
position dozens of times per second. That frame-by-frame tracking feed
is not publicly redistributed and is not bundled in any package
available to us, the same kind of real access gap Module 4 hit with
its Chapter 4 LBA data.

So, as with Module 4, I built this module's real computation on the
closest real, freely available substitute: `BasketballAnalyzeR::PbP.BDB`'s
real shot-location data. Every real field goal attempt in this dataset
carries its own real court coordinates, `original_x` and `original_y`,
in tenths of a foot from the basket. That is event-level spatial data,
not frame-by-frame tracking, so I cannot reproduce the textbook's real
speed and acceleration curves (Section 5.1.3) or its full,
tracking-based Gravity and distraction metric (Section 5.2) from this
data. What I can do, and what this module actually does with real
data, is apply the chapter's two core spatial techniques, convex hulls
and Voronoi tessellation, directly to real shot locations instead of
real live player positions, and add a real kernel-density view of a
player's spatial shot distribution (Section 5.3).

## Real convex hulls: a player's shot territory

A convex hull is the smallest polygon that contains every point in a
set. Applied to a player's real shot locations across a season, it
draws the actual real boundary of where that player takes shots from,
what I am calling his shot territory. I computed this for two real
Golden State Warriors regulars from the 2017-18 season with very
different real roles: Stephen Curry and Draymond Green.

Stephen Curry's real shot-territory convex hull covers 2,538 square
feet, built from 864 real shot attempts that reach every part of the
half court, from the top of the key to both corners to well beyond the
three-point line. Draymond Green's real hull covers 2,264 square feet
from 619 real attempts, a smaller and differently shaped territory
concentrated closer to the basket and the short midrange, with far
fewer real attempts from the deep corners. Both real hulls overlap
heavily near the rim, where almost every player of any role ends up
taking some real shots, but the two shapes diverge sharply everywhere
else. That divergence is a real, visual answer to a question a single
shooting percentage can never answer: not just how well a player
shoots, but from where.

## Real spacing across the full real rotation

Convex hull area, computed the same way across every real GSW rotation
player with a meaningful real sample, gives a real, ranked view of
floor coverage. Real hull area does not simply track real shot volume.
Kevin Durant led the real 2017-18 Warriors roster in shot attempts in
this sample (1,221 real attempts) but his real shot-territory hull
(2,018 square feet) was smaller than both Klay Thompson's (2,599
square feet, from 1,178 real attempts) and Curry's (2,538 square feet).
Durant took more real shots than anyone, but from a more compact real
area of the floor than the team's two primary movement shooters. Real
floor coverage and real shot volume are two different questions, and
this module's data keeps them separate on purpose.

## Real Voronoi tessellation: dividing the floor by shooting tendency

A Voronoi tessellation divides a plane into regions, one per seed
point, where every location in a given region is closer to that
region's seed than to any other. Applied to a real set of players'
typical shooting locations, it produces a literal real map of which
part of the floor "belongs" to which shooter, in the sense of being
closer to that player's own real shooting habits than to any teammate's.

I built each real Warriors regular's seed point from the real median
location of his own three-point and long two-point attempts (excluding
shots within 10 feet of the basket, since nearly every player's single
most common shot is a rim attempt, which would collapse every seed to
the same point and defeat the purpose of the map). The resulting real
tessellation gives Draymond Green and Stephen Curry, the two players
whose real median jump-shot locations sit furthest from the pack, the
two largest real regions on the floor, while the bench rotation's real
median locations cluster tightly near the free-throw line and split a
much smaller, more contested real region among several players. That
pattern is a real, spatial version of the same star-versus-role-player
distinction we have seen all course in box score numbers, just drawn
directly onto the court.

## Real spatial distribution: the full shape of a shot profile

A convex hull tells you the boundary of where a player shoots. It does
not tell you where, inside that boundary, the player actually shoots
most often. For that I built a real two-dimensional kernel density
estimate of shot location, comparing Stephen Curry against JaVale
McGee, a real 2017-18 Warriors center. McGee's real shot distribution
is a single sharp peak within a few feet of the basket, exactly what
you would expect from a real rim-running center with 219 real
attempts averaging 5.0 feet from the basket. Curry's real distribution
is fundamentally different in shape, not just larger: alongside a real
peak at the rim, it shows a genuine second real ridge of density along
the three-point arc, with visible real concentration on the wings,
averaging 18.9 feet from the basket across 864 real attempts. Two very
different real shapes, not just two different real averages.

## Gravity, distraction, and what real tracking data would add

The textbook's Section 5.2 connects this chapter's spatial techniques
to "gravity," a term the NBA's own advanced-stats platform now tracks
directly: a real, official NBA.com stat that uses 3D pose detection
across 29 body points per player, sampled 60 times per second, to
measure how much defensive attention a player draws relative to a
model's expectation, both with and without the ball. That is a real,
frame-by-frame tracking-based metric fundamentally out of reach of the
event-level shot data this module works with. I am not going to fake a
gravity number from data that cannot support one. What this module's
real convex-hull and Voronoi results do show, honestly, is a real
spatial proxy for the same underlying idea: a player whose real shot
territory and real median shooting location sit far from the basket
and far from his teammates' own territories is, by simple geometry,
forcing defenders to cover more real ground than a player whose shots
cluster in one small area. A 2025 peer-reviewed paper (Barron,
Sitaraman & Arias, *Scientific Reports*) makes a version of this same
point with real optical tracking data, finding that the real gap
between elite and poor real defensive positioning is worth
approximately 3 points per game, and that real defenders built to
guard the rim are measurably weaker, in real data, at covering the
three-point line. That is exactly the kind of tracking-based finding
this module's shot-location proxy gestures toward without being able
to fully replicate.

## Why this belongs in the course, and where it leads

Spatial dynamics is where basketball analytics stops treating the
court as a backdrop and starts treating it as data. Every real number
in this module, both hull areas, the real jump-shot centroids behind
the Voronoi map, and the real kernel densities, came directly from
`BasketballAnalyzeR::PbP.BDB`'s real shot-location coordinates and can
be reproduced by running
`Coding_Exercise/module5_spatial_dynamics.R`. For students headed
toward a larger independent project, this module's spatial techniques
are also a real, direct on-ramp to the PhD track in Module 10: the
same real convex-hull and density tools used here to describe where a
player shoots are the same class of tool sports-medicine researchers
use to describe where and how a player moves before connecting that
movement pattern to injury risk.
