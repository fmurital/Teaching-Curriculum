# Lab 2: Four Factors and Team Ratings

**Goal:** compute pace, offensive/defensive rating, and the Four Factors
for every team in the 2017-18 NBA season, using the real data bundled
with `BasketballAnalyzeR`, and use them to answer a question raw box
scores cannot.

## Setup

Open `Coding_Exercise/module2_four_factors.R` in RStudio, or start a fresh
script and follow along. You will need the `BasketballAnalyzeR` package
(installed in Module 1's lab).

```r
library(BasketballAnalyzeR)
data(Tbox)
data(Obox)
```

`Tbox` is each team's own season box score; `Obox` is what that team's
*opponents* did against it. You need both to compute pace and the Four
Factors, because a possession is defined by what happens between the two
teams, not by one team's stats alone.

## Part 1: Compute the Four Factors

```r
FF <- fourfactors(Tbox, Obox)
FF$Team <- Tbox$Team
FF$W <- Tbox$W
FF$L <- Tbox$L
str(FF)
```

Look at the column names. `PACE.Off`, `ORtg`, `DRtg`, and eight columns
named `F1.Off` through `F4.Def` (the four offensive factors, then the
four defensive factors).

## Part 2: Pace

```r
FF$Pace48 <- round(FF$PACE.Off * 48, 1)
FF[order(-FF$Pace48), c("Team", "Pace48", "W")][1:5, ]
mean(FF$Pace48)
range(FF$Pace48)
```

1. Which five teams played fastest? Does playing fast seem related to
   winning, just from looking at this table?
2. What is the leaguewide average pace, and how wide is the gap between
   the fastest and slowest team?

## Part 3: Ratings

```r
FF[order(-FF$ORtg), c("Team", "ORtg", "DRtg", "W")][1:5, ]
FF[order(FF$DRtg), c("Team", "DRtg", "W")][1:5, ]
FF$NetRtg <- FF$ORtg - FF$DRtg
cor(FF$F1.Off, FF$W)
cor(FF$NetRtg, FF$W)
```

3. Which correlation is stronger: shooting efficiency alone, or net
   rating? By how much?
4. Find your own answer to "why" before reading the module notes' answer.

## Part 4: The Four Factors, weighed against real outcomes

```r
c(eFG = cor(FF$F1.Off, FF$W),
  TOVrate = cor(FF$F2.Off, FF$W),
  ORBrate = cor(FF$F3.Off, FF$W),
  FTrate = cor(FF$F4.Off, FF$W))
```

5. Rank the four offensive factors from strongest to weakest correlation
   with wins in this specific season. Does the ranking match Dean
   Oliver's original 40/25/20/15 weighting?

## Part 5: One team, all the way through

```r
FF[FF$Team == "Houston Rockets",
   c("Team", "Pace48", "ORtg", "DRtg", "F1.Off", "F2.Off", "F3.Off", "F4.Off", "W")]
```

6. Pick a different team from `FF$Team` and pull the same row. Compare it
   to the Rockets. What is that team's biggest strength and biggest
   weakness among the four factors?

## Part 6: The full-league chart

```r
plot(FF, title = "2017-18 NBA Season -- Four Factors")
```

7. This produces four panels at once (pace, ratings, offensive factors,
   defensive factors). Pick one panel and describe, in a sentence or two,
   what it would tell a coach who had never seen it before.

## Reflection (submit with your lab)

8. In your own words: why is net rating a better single predictor of
   wins than any one of the Four Factors alone? What does that imply
   about relying on a single stat to evaluate a team?

## Extension (optional, not graded)

Cross-reference your chosen team's factors against `Tadd$Playoff` (loaded
with `data(Tadd)`) to see whether it made the playoffs that season, and
whether its profile looks more like a top-5 or bottom-5 team by net
rating.
