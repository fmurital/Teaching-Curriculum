# Lab 02: Beyond Individual Skills — Lineups and Combinations

**Graduate — Sports Analytics.** Run this in RStudio, live, alongside the lecture. Needs `BasketballAnalyzeR`, `operators`, `pbapply`, `combinat`, `gridExtra`, `dplyr`, `network`, and `ggnetwork` (all from Module 01's setup).

## Part 1: Find real lineups for the 2021-22 Golden State Warriors

```r
pacman::p_load(BasketballAnalyzeR, operators, pbapply, combinat, gridExtra, dplyr)
load("./Data/NBAPbP_BDB.Rdata")
PbP.GSW.rs <- PbPmanipulation(PbP.BDB.GSW.rs)

nplayers <- 5
teamplayers <- c("Andrew Wiggins","Draymond Green","Gary Payton II",
  "Jonathan Kuminga","Jordan Poole","Kevon Looney","Klay Thompson",
  "Otto Porter Jr.","Moses Moody","Stephen Curry")
min_time_l <- 48

cat("No. of combinations =", nCm(length(teamplayers), nplayers), "\n")

source("additional_functions.r")
ktuples <- lineups(PbP.GSW.rs, teamplayers, k = nplayers)
lineup_set <- ktuples %>% filter(MIN >= min_time_l)
print(lineup_set)
```

Confirm your output matches the lecture: exactly eight lineups, with Wiggins/Green/Poole/Looney/Curry at the top with 346.1 minutes.

## Part 2: Build one lineup's assist-shot network

Pick any lineup from your `lineup_set` other than the primary starting group. Filter the play-by-play data to that lineup's minutes, then run:

```r
pacman::p_load(network, ggnetwork)
subdatak.GSW <- <your filtered play-by-play for this lineup>
out <- assistnet(subdatak.GSW)
plot(out, layout = "circle", edge.thr = 0, node.col = "ASTPTS", node.size = "FGPTS_ASTp")
```

Who is the hub of your lineup's network? Is it still Stephen Curry, or does it change when he isn't on the floor for a particular combination?

## Part 3: Lineup-level Four Factors and Pace

```r
TOPPbP <- subdatak.GSW %>%
  mutate(oreb = ..., dreb = ..., turnover = ..., PF = ...)  # see Module 01 pipeline
TOP <- TOPboxes(TOPPbP, team = "GSW")
Tbox_lineup <- TOP$Tbox
Obox_lineup <- TOP$Obox

FF <- fourfactors(Tbox_lineup, Obox_lineup)
plot(FF)
```

Compare your lineup's Pace and Ratings to the two extremes from the lecture: the fastest, most efficient lineup (Wiggins+Green+Poole+Porter Jr.+Curry) and the worst defensive lineup (Wiggins+Green+Poole+Looney+Thompson). Where does yours fall?

## Before you leave

Save your script and your lineup's network plot. You will extend this pipeline to a team of your own choosing in Homework Assignment 2.
