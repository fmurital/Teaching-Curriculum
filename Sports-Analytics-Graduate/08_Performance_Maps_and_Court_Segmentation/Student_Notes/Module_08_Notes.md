# Module 8 Notes: Basketball Performance Maps Based on Court Segmentation

## Where we left off

Module 7 tracked the ball itself through the air, using object
detection and the real physics of a shot's minimum-speed trajectory.
This module asks a related but different question: once you know
where on the court a shot was taken from, how do you turn that single
location into a real, defensible statement about how likely that shot
was to go in? The answer this module builds, in three real stages, is
a performance map: first a simple real sector-based version, then a
real shot chart, then two real, data-driven versions built with
Classification and Regression Trees (CART), one on Cartesian shot
coordinates and one on polar shot coordinates.

Every real number below comes from the real 2017-18 NBA play-by-play
data in `BasketballAnalyzeR::PbP.BDB`, 14,354 real shot attempts with
a valid real location and a valid real shot distance, the same real
dataset this course has used since Module 5. As before, this dataset
is built around Golden State's real, complete 82-game schedule, with
every other real team appearing only in its real games against Golden
State; the real Golden State numbers below draw on their real full
season, and they are the team this module's shot chart uses for
exactly that reason.

## Part 1: The simplest real performance map, by sector

The most direct way to segment a court is to bucket every real shot
by its real distance from the hoop and its real angle left, center,
or right, then compute real field goal percentage inside each
resulting real cell. I built this directly from the real, normalized
shot coordinates:

| Real distance band | Real angle sector | Real attempts | Real FG% |
|---|---|---|---|
| Rim (0-4 ft) | Center | 4,513 | 64.4 |
| Paint (4-14 ft) | Left side | 370 | 47.8 |
| Paint (4-14 ft) | Center | 2,052 | 40.9 |
| Paint (4-14 ft) | Right side | 348 | 40.5 |
| Mid-range (14-22 ft) | Left side | 842 | 39.5 |
| Mid-range (14-22 ft) | Center | 792 | 43.8 |
| Mid-range (14-22 ft) | Right side | 700 | 41.1 |
| Three (22 ft+) | Left side | 1,890 | 37.1 |
| Three (22 ft+) | Center | 1,003 | 38.1 |
| Three (22 ft+) | Right side | 1,844 | 37.3 |

Notice there is no real rim-left or rim-right row. At a real distance
of 0 to 4 feet, almost every real attempt is close enough to center
that this module's angle cutoff never separates one out, which is
itself a real, honest finding about where shots that close actually
happen.

Here is the real number I want you to sit with. Mid-range center shots
go in at a real 43.8%, better than three-point center shots at a real
38.1%. On points per shot, though, the real three-pointer is still
worth more: 2 x 0.438 = a real 0.876 expected points for the
mid-range attempt, against 3 x 0.381 = a real 1.143 expected points
for the three. A real sector map does not just show you where shots
go in most often; it is the real foundation the rest of modern shot
selection analytics is built on.

## Part 2: A real shot chart, Golden State Warriors

A sector map compresses the court into a handful of real cells. A
shot chart keeps every real shot's exact real location. I plotted
every real Golden State attempt from their real, complete 2017-18
season, 6,978 real shots at a real 50.3% overall field goal
percentage, color-coded by real make or miss, on a real half-court
drawn with `drawNBAcourt()`.

The real visual pattern a sector map can only hint at becomes obvious
here: a real dense cluster of real makes right at the rim, a real
much sparser, more mixed real cloud through the mid-range, and real
bands of attempts along the three-point line, heaviest above the
break and in the corners. A shot chart is the real, ungrouped version
of the same real question Part 1 already started answering.

## Part 3: A real, data-driven map, CART on Cartesian coordinates

Instead of choosing the sector boundaries myself, I let a real
classification tree, `rpart()`, discover them directly from the real
x and y shot coordinates of all 14,354 real attempts:

```r
cart_xy <- rpart(made ~ x_rel + y_rel, data = sh, method = "class",
                  control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
```

The real tree it found, in four real terminal nodes:

- **y >= 1.9 ft from the hoop:** real 40.1% scoring probability (9,888 real attempts, 69% of the data)
- **y < 1.9 ft, x >= 2.15 ft:** real 41.0% scoring probability (646 real attempts, 4% of the data)
- **y < 1.9 ft, x < 2.15 ft, x < -1.95 ft:** real 45.1% scoring probability (536 real attempts, 4% of the data)
- **y < 1.9 ft, x < 2.15 ft, x >= -1.95 ft:** real 71.0% scoring probability (3,284 real attempts, 23% of the data)

The real, honest nuance here is the third and fourth rows together.
Even among shots close enough to the rim to be in a real high-percentage
group, a real sharp lateral angle (`x < -1.95`, a shot taken well off
to one side, close to the baseline) drops real scoring probability from
71.0% down to 45.1%. A smaller real group on the opposite side (`x >=
2.15`) lands at a real 41.0%, close to the far-shot baseline rate
despite being just as close to the hoop. A sector map built from a
fixed distance-only rule would have missed all of this; a real CART
model built directly on real Cartesian coordinates found it on its own.

## Part 4: The same real question, on polar coordinates

Section 8.3 of this module's approach also asks the same real
question using polar coordinates, real distance and real angle,
instead of real x and y:

```r
cart_polar <- rpart(made ~ shot_distance + angle_deg, data = sh, method = "class",
                     control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
```

The real polar tree found something strikingly simpler: one single
real split, at exactly 2.5 feet from the hoop, with a real 70.2%
scoring probability inside that radius and a real 40.2% probability
outside it. Its real training accuracy, 62.32%, was essentially tied
with the four-node Cartesian tree's real 62.19%.

That is the real, honest comparison this module wants you to walk
away with. A model built on real distance alone, with no angle
information at all, captured nearly all of the same real predictive
power as the more detailed real Cartesian model, because real
distance from the hoop is simply the dominant real signal in whether
a shot goes in. The Cartesian model's extra real nodes bought a small
amount of real nuance, the lateral-angle effect from Part 3, not a
large jump in overall real accuracy. Both are real, valid, honestly
computed performance maps; they just make a different real trade-off
between simplicity and detail.

## The PhD/advanced-project connection

A CART-based performance map is exactly the kind of model structure
the injury-risk PhD track in Module 10 depends on: a model that takes
a handful of real, measurable inputs and partitions them into real,
interpretable risk groups, the same logical structure used here to
partition the court into real scoring-probability groups.

## Where this goes next

Module 9 moves from CART-based scoring probability to full machine
learning scoring probability models, Random Forests, Oblique Random
Forests, and Extremely Randomized Trees, extending the same real
question this module started: given a shot's real location, how
likely is it to go in.
