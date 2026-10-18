# Lab 3: Clutch Performance and Situational Splits

**Goal:** reproduce the textbook's clutch-splits methodology on
Golden State's real full 2017-18 regular-season play-by-play log, for
two real teams (Golden State's full season, and Boston's two real
regular-season games against Golden State that year), and use it to
evaluate real players' clutch performance.

## Setup

Open `Coding_Exercise/module3_clutch_splits.R` in RStudio, or start a
fresh script and follow along.

```r
library(BasketballAnalyzeR)
library(dplyr)
library(gridExtra)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
```

`PbP.BDB` is real, event-level play-by-play data for Golden State's
entire 2017-18 regular season (any opponent's own numbers in this data
are limited to the real games that opponent played against Golden
State that year).

## Part 1: Build the variables `TOPboxes()` needs

`TOPboxes()`, the function that turns play-by-play data into team,
opponent, and player box scores, requires several variables that are
not present in the raw data by default.

```r
`%~%` <- function(x, pattern) grepl(pattern, x, fixed = TRUE)

TOPPbP <- PbP %>%
  mutate(across(c(game_id, ShotType, result, team, assist, block,
                  steal, player, h1, h2, h3, h4, h5, a1, a2, a3, a4, a5,
                  hometeam, type, event_type), as.character)) %>%
  mutate(
    oreb = type %~% "rebound offensive",
    dreb = type %~% "rebound defensive",
    turnover = event_type == "turnover",
    PF = (event_type == "foul") & !(type %~% "technical")
  )
```

1. In your own words, why does `TOPboxes()` need an explicit `oreb`/`dreb`
   indicator rather than inferring rebounds from the `event_type` column
   alone?

## Part 2: Define the clutch situation and filter

```r
totalTime_c <- 2580
scorediff_c <- 5

TOPPbPc <- TOPPbP %>%
  mutate(scorediff = abs(home_score - away_score)) %>%
  filter(scorediff <= scorediff_c & totalTime > totalTime_c)
```

2. `totalTime_c <- 2580` sets the clutch threshold at 2,580 seconds.
   Show the arithmetic that confirms this is "less than five minutes
   remain in a 48-minute game."

## Part 3: Team box scores, Clutch versus General

```r
Team <- "GSW"
TOP  <- TOPboxes(TOPPbP,  team = Team)
TOPc <- TOPboxes(TOPPbPc, team = Team)

Tboxes <- data.frame(Team = c("Clutch","General"), rbind(TOPc$Tbox, TOP$Tbox))
Oboxes <- data.frame(Team = c("Clutch","General"), rbind(TOPc$Obox, TOP$Obox))

FF <- fourfactors(Tboxes, Oboxes)
print(FF[, c("Team","ORtg","DRtg")])
```

3. Report Golden State's real Clutch and General offensive and
   defensive ratings. Did their offense or their defense change more
   between the two splits?

4. Repeat Part 3 for `Team <- "BOS"`. Compare the direction of Boston's
   offensive-rating shift to Golden State's. Are the two teams' clutch
   shifts moving the same direction or opposite directions?

## Part 4: Scoring inequality

```r
ineqc <- inequality(TOPc$Pbox$PTS, nplayers = min(10, nrow(TOPc$Pbox)))
ineq  <- inequality(TOP$Pbox$PTS,  nplayers = min(10, nrow(TOP$Pbox)))
plot(ineqc, title = "Clutch")
plot(ineq,  title = "General")
```

5. Report the real Gini coefficient for both splits, for whichever team
   you are working with. Does scoring become more or less concentrated
   in the clutch?

## Part 5: Player-level clutch indices

Follow the full derivation in `Coding_Exercise/module3_clutch_splits.R`
(the `SP`, `SPc`, `Diff`, `Prc`, and `MINcp` variables), then inspect the
result:

```r
print(cindex)
```

6. Find the player with the largest positive `Diff` in your team's real
   data. What does a positive `Diff` mean, in terms of `SPc` and `SP`?

7. Find the player with the largest `Prc` (propensity to shoot) in your
   team's real data. Does that player also have a large `MINcp`? What
   would it mean if a player had a high `Prc` but a low `MINcp`?

## Part 6: Connecting to the literature

8. Goldman & Rao (2012) argue that pressure affects NBA players
   asymmetrically -- some respond with more effort, others with reduced
   shooting efficiency. Pick one real player from your `cindex` table
   whose `Diff` and `Prc` values are consistent with this asymmetric
   pattern, and explain, in two or three sentences, which side of the
   pattern they fall on.

## Reflection (submit with your lab)

9. This module uses Golden State's real regular-season log rather than
   the textbook's own private regular-season-plus-playoffs file, and
   Boston's own split comes from only two real games rather than a full
   season. In your own words, what real tradeoff does that make, and how
   did it show up in this lab (for example, in how many players cleared
   the clutch shot-attempt threshold)?

## Extension (optional, not graded)

Pick a third real team from `unique(PbP$team)` (any other team Golden
State played in 2017-18) and run the full Clutch-versus-General
pipeline for that team, keeping in mind its sample will be limited to
however many real games it played against Golden State that season.
Report its real Gini shift and its most extreme `Diff` player.
