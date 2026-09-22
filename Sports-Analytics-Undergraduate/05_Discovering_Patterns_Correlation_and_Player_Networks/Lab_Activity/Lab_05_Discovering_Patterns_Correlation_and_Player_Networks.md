# Lab 5: Discovering Patterns, Correlation and Player Networks

**Goal:** compute a real correlation matrix from 2017-18 NBA per-minute
box score rates, then build and compare two real assist networks to
see how differently two real NBA offenses actually distributed
playmaking.

## Setup

Open `Coding_Exercise/module5_correlation_networks.R` in RStudio, or
start a fresh script and follow along.

```r
library(BasketballAnalyzeR)
library(dplyr)

data(Pbox)
cat("Total players in Pbox (2017-18 season):", nrow(Pbox), "\n")
```

`Pbox` holds real season box score totals for every player who
appeared in a 2017-18 NBA game, 605 players in total.

## Part 1: Real per-minute rates and a real correlation matrix

A player who only logged a handful of minutes can post an extreme
per-minute rate off a tiny sample, so I filter to players with at
least 500 real minutes played before computing anything.

```r
rates <- Pbox %>%
  filter(MIN >= 500) %>%
  mutate(
    PTSpm = PTS/MIN, ASTpm = AST/MIN, TOVpm = TOV/MIN,
    OREBpm = OREB/MIN, DREBpm = DREB/MIN, STLpm = STL/MIN, BLKpm = BLK/MIN
  ) %>%
  select(Player, PTSpm, ASTpm, TOVpm, OREBpm, DREBpm, STLpm, BLKpm)

cat("Players with >=500 minutes played:", nrow(rates), "\n")

cc <- corranalysis(rates %>% select(-Player), threshold = 0.5)
print(round(cc$cor.mtx, 3))
```

1. How many real players are left after the 500-minute filter, and why
   does filtering out low-minute players matter before you compute a
   correlation matrix?

```r
plot(cc)
```

2. Look at the plotted correlation matrix (an ellipse for every pair
   of stats, red for negative and blue for positive). Find the three
   strongest real correlations in the matrix. What do offensive
   rebounds and defensive rebounds have in common, in terms of the
   correlation coefficient between them and in terms of what actually
   produces both stats on the floor?

3. Assists and turnovers have a real correlation of 0.687, a strong
   positive number. Explain, in your own words, why a stat most people
   think of as bad (turnovers) would be positively correlated with a
   stat most people think of as good (assists), rather than negatively
   correlated.

## Part 2: Building a real assist network

A correlation matrix tells you which *stats* move together. An
assist network tells you which *players* connect to each other. This
part uses `BasketballAnalyzeR::PbP.BDB`, real play-by-play data built
around the Golden State Warriors' full 82-game 2017-18 regular season
schedule. Every other team's rows in this dataset are that team's own
real regular-season game(s) against Golden State specifically.

```r
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

anet_hou <- assistnet(subset(PbP, team == "HOU"))
ns_hou <- anet_hou$nodeStats[order(-anet_hou$nodeStats$AST),
                              c("player","AST","ASTPTS","FGM_AST","FGM","FGM_ASTp")]
print(ns_hou)
plot(anet_hou)
```

4. Houston's data here covers three real 2017-18 regular-season games
   against Golden State. Who led the team in real assists, and how
   many points did his assists create (`ASTPTS`)? What share of
   Houston's total real assists did that player account for? (Team
   total: 67 real assists.)

```r
anet_cle <- assistnet(subset(PbP, team == "CLE"))
ns_cle <- anet_cle$nodeStats[order(-anet_cle$nodeStats$AST),
                              c("player","AST","ASTPTS","FGM_AST","FGM","FGM_ASTp")]
print(ns_cle)
plot(anet_cle)
```

5. Cleveland's data here covers two real 2017-18 regular-season games
   against Golden State, including the real, nationally televised
   Christmas Day matchup. Who led Cleveland in real assists, and what
   share of Cleveland's total real assists (38 team total) did that
   one player account for?

6. Compare your answers to questions 4 and 5. In your own words,
   describe the difference between Houston's real assist network and
   Cleveland's real assist network. Which team's offense looks more
   like a "hub and spoke," with one central playmaker, and which looks
   more distributed across several real ball-handlers?

## Reflection (submit with your lab)

7. Pick one of this module's three strongest real correlations
   (offensive/defensive rebounds at 0.729, assists/turnovers at
   0.687, or offensive rebounds/blocks at 0.630) and explain, in two
   or three sentences, why a strong correlation between two stats does
   not automatically mean one stat causes the other.

8. A team's front office is deciding how much to invest in a single
   star ball-handler versus spreading playmaking responsibility across
   several players. Using the real Houston-versus-Cleveland comparison
   from this lab, describe one real risk of the hub-and-spoke approach
   and one real advantage of the distributed approach.

## Extension (optional, not graded)

`PbP.BDB` is built around Golden State's schedule, so only the
handful of real opponents Golden State actually played in the 2017-18
regular season have any games in this dataset, and most of those
opponents only appear in one or two real games. Run
`unique(PbP$team)` to see the full list of real teams available, pick
one you have not already looked at, build its own real assist network
with `assistnet()`, and write two or three sentences comparing its
real playmaking distribution to Houston's and Cleveland's.
