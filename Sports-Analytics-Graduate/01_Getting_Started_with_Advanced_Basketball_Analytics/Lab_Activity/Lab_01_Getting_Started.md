# Lab 01: Getting Started with Advanced Basketball Analytics

**Graduate — Sports Analytics.** Run this in RStudio, live, alongside the lecture. You need `BasketballAnalyzeR` installed (from the undergraduate course setup) plus `network`, `sna`, `GGally`, and `ggnetwork` for this lab's second half.

## Part 1: Setup, the book's way

```r
if (!requireNamespace("pacman", quietly = TRUE)) install.packages("pacman")
library(pacman)
p_load(dplyr, BasketballAnalyzeR)

library(conflicted)
conflict_prefer("filter", "dplyr")
conflict_prefer("arrange", "dplyr")
```

Run it. If a package installs during `p_load()`, that is expected the first time; it will not reinstall on future runs.

## Part 2: The top-scorers pipeline (as shown in Segment I)

```r
data(Pbox)

top_scorers <- Pbox %>%
  filter(MIN >= 500) %>%
  mutate(PPG = round(PTS / GP, 1)) %>%
  select(Player, Team, GP, MIN, PTS, PPG) %>%
  arrange(desc(PPG)) %>%
  slice(1:8)

print(top_scorers)
```

Confirm your output matches the lecture: James Harden at the top (30.4 PPG), Russell Westbrook rounding out the group at 25.4.

**Now change the question.** Rebuild the pipeline to answer: which eight players had the best rebounds-per-game among those with at least 1,000 minutes played? You will need `TREB` (or the rebounding column as named in `Pbox` — check `colnames(Pbox)` if unsure) instead of `PTS`, and a different `filter()` threshold. Compare your top eight to the person next to you. Did you get the same list?

## Part 3: A real assist network for the Golden State Warriors

```r
p_load(network, sna, GGally, ggnetwork)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

nba_teams <- c("Golden State Warriors")
out <- assistnet(PbP, team = nba_teams)

colnames(out$nodeStats)
head(out$nodeStats[order(-out$nodeStats$AST), ], 8)

plot(out)
```

Confirm your `nodeStats` table shows Draymond Green leading the team in total assists (509), ahead of Kevin Durant (366) and Stephen Curry (309). Look at the `FGM_ASTp` column (or equivalent percentage-assisted column) for Klay Thompson and Kevin Durant — you should see roughly 83% for Thompson and 54% for Durant. That gap is the whole point of this lab: two players can have similar scoring roles on paper and completely different roles in how their points are created.

**Now change the team.** Rerun Part 3 with a different team from the 2017-18 season (check `unique(Pbox$Team)` for the full list of names as they appear in the data). Who leads your chosen team in assists? Is there a player with a very high or very low assisted-shot percentage? Bring your answer to the discussion at the start of next class.

## Before you leave

Save your script. You will extend both pipelines in Homework Assignment 1.
