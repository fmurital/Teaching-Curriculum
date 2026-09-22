# Lab 4: Season Segments and Final Rankings

**Goal:** build real per-game box scores for an entire real NBA season,
implement the textbook's `AdjRtg()` formula from scratch, compare two
real season segments, and use a real CART tree and alluvial diagram to
explore what predicts real wins in this sample.

## Setup

Open `Coding_Exercise/module4_season_segments.R` in RStudio, or start a
fresh script and follow along.

```r
library(BasketballAnalyzeR)
library(dplyr)
library(ggplot2)
library(ggalluvial)
library(zoo)
library(rpart)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
cat("Real data_set label(s):", paste(unique(as.character(PbP$data_set)), collapse=", "), "\n")
```

Check the `data_set` label this prints, and check `length(unique(PbP$game_id))`.

1. Before reading any further, use `table(PbP$team)` or a similar check
   on the raw data to convince yourself which single team appears in
   every game in this file, and confirm that no two non-GSW teams ever
   play each other in it. Write down, in your own words, why this
   dataset has a "hub and spoke" shape rather than the shape of a
   normal league season.

## Part 1: Build real per-game box scores

The textbook builds its season-long analysis one real game at a time
(the same `TOPboxes()`/`fourfactors()` approach from section 1.4.1).
This module does the same:

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

game_ids <- unique(TOPPbP$game_id)

build_game_row <- function(gid) {
  gdat <- TOPPbP %>% filter(game_id == gid)
  teams_in_game <- unique(gdat$team[!is.na(gdat$team) & gdat$team != ""])
  home <- unique(gdat$hometeam[!is.na(gdat$hometeam) & gdat$hometeam != ""])
  if (length(home) == 0 || length(teams_in_game) != 2) return(NULL)
  home <- home[1]
  away <- setdiff(teams_in_game, home)
  if (length(away) != 1) return(NULL)
  TOP <- tryCatch(TOPboxes(gdat, team = home), error = function(e) NULL)
  if (is.null(TOP)) return(NULL)
  Tbox <- TOP$Tbox; Obox <- TOP$Obox
  Tbox$Team <- home; Obox$Team <- away
  FF <- tryCatch(fourfactors(Tbox, Obox), error = function(e) NULL)
  if (is.null(FF)) return(NULL)
  data.frame(
    game_id = gid, game_date = gdat$date[1],
    home_team = home, away_team = away,
    home_score = Tbox$PTS, away_score = Obox$PTS,
    home_poss = FF$POSS.Off, away_poss = FF$POSS.Def
  )
}

games_list <- lapply(game_ids, build_game_row)
games_info <- bind_rows(games_list) %>% arrange(as.Date(game_date, format = "%m/%d/%Y"))
nrow(games_info)
```

2. Run this and report how many real games you ended up with in
   `games_info`. Why does the function build one game at a time,
   rather than passing the whole season's play-by-play into
   `TOPboxes()` in a single call?

## Part 2: Implement `AdjRtg()` from the textbook's formulas

```r
AdjRtg <- function(gi) {
  teams <- sort(unique(c(gi$home_team, gi$away_team)))
  N <- length(teams)
  P <- matrix(0, N, N, dimnames = list(teams, teams))
  Poss <- matrix(0, N, N, dimnames = list(teams, teams))
  for (k in seq_len(nrow(gi))) {
    h <- gi$home_team[k]; a <- gi$away_team[k]
    P[h, a] <- P[h, a] + gi$home_score[k]; Poss[h, a] <- Poss[h, a] + gi$home_poss[k]
    P[a, h] <- P[a, h] + gi$away_score[k]; Poss[a, h] <- Poss[a, h] + gi$away_poss[k]
  }
  R <- P / Poss
  R[Poss == 0] <- NA
  wavg <- function(v, w) { ok <- !is.na(v) & !is.na(w) & w > 0; if (!any(ok)) return(NA); sum(v[ok]*w[ok])/sum(w[ok]) }
  ORtg <- sapply(seq_len(N), function(i) wavg(R[i, ], Poss[i, ]))
  DRtg <- sapply(seq_len(N), function(j) wavg(R[, j], Poss[, j]))
  names(ORtg) <- teams; names(DRtg) <- teams
  offij <- sweep(R, 2, DRtg, "-")
  defji <- sweep(R, 1, ORtg, "-")
  AORtg <- sapply(seq_len(N), function(i) wavg(offij[i, ], Poss[i, ]))
  ADRtg <- sapply(seq_len(N), function(j) wavg(defji[, j], Poss[, j]))
  data.frame(team = teams, GP = sapply(teams, function(t) sum(gi$home_team==t | gi$away_team==t)),
             ORtg = round(ORtg*100,2), DRtg = round(DRtg*100,2),
             AORtg = round(AORtg*100,2), ADRtg = round(-ADRtg*100,2))
}

full_season <- AdjRtg(games_info) %>% arrange(desc(AORtg))
print(full_season)
```

3. Point to the exact line in `AdjRtg()` where a team's raw pairwise
   scoring rate against an opponent gets compared to that opponent's
   own rating. In your own words, what is this line trying to correct
   for?

## Part 3: Two real season segments

```r
half <- ceiling(nrow(games_info)/2)
seg1 <- games_info[1:half, ]
seg2 <- games_info[(half+1):nrow(games_info), ]

ar1 <- AdjRtg(seg1)
ar2 <- AdjRtg(seg2)
```

4. Report GSW's real record, `ORtg`, and `DRtg` for the full season,
   segment 1, and segment 2 (use `full_season`, `ar1`, and `ar2`, plus
   a simple win/loss count on `games_info`). Which side of GSW's game,
   offense or defense, moved more between the two real segments?

## Part 4: The real near-zero adjusted rating

```r
print(ar1[ar1$team == "GSW", c("AORtg","ADRtg")])
print(ar2[ar2$team == "GSW", c("AORtg","ADRtg")])
```

5. Report the exact values you get. Then, without looking back at the
   Student Notes, try to explain in your own words why these come out
   the way they do, using the structure of who-played-whom in this
   dataset. After you have written your own explanation, compare it to
   the Student Notes' explanation and note anything you got right or
   missed.

6. Now look at a non-GSW team's real `AORtg` in `full_season` (pick any
   team other than GSW). Explain why that team's adjusted rating does
   not collapse to zero the same way GSW's does, even though that team
   also only appears in this dataset playing GSW.

## Part 5: A real CART tree and alluvial diagram

```r
wins <- games_info %>% mutate(winner = ifelse(home_score > away_score, home_team, away_team)) %>%
  count(winner, name="wins_in_sample")

ar1r <- ar1 %>% rename(AORtg1=AORtg, ADRtg1=ADRtg)
ARtg <- ar1r %>% left_join(wins, by=c("team"="winner")) %>%
  mutate(wins_in_sample = ifelse(is.na(wins_in_sample), 0, wins_in_sample))

cart_df <- ARtg %>% filter(!is.na(AORtg1) & !is.na(ADRtg1))
tree <- rpart(wins_in_sample ~ AORtg1 + ADRtg1, data=cart_df, control=rpart.control(minsplit=4, cp=0.05))
print(tree)
plot(tree, margin=0.15); text(tree, use.n=TRUE, cex=0.85)
```

7. Report the tree's first split. Does it agree with the value
   reported in the Student Notes (`AORtg1 < -0.015`)? If your numbers
   differ slightly, check whether you filtered `cart_df` the same way.

8. Open `Coding_Exercise/module4_alluvial.png`. Pick one team whose
   ribbon is easy to trace across all three columns (segment-1 `AORtg1`
   category, segment-1 `ADRtg1` category, team) and describe, in one or
   two sentences, what its path through the diagram tells you about
   the relationship between its segment-1 ratings and its real wins in
   this sample.

## Part 6: Season evolution

Open `Coding_Exercise/module4_gsw_season_evolution.png` (the real
10-game rolling net rating across all 82 of GSW's real 2017-18 games)
and `Coding_Exercise/module4_gsw_season_log.csv`.

9. Find the real Christmas Day game against Cleveland in
   `module4_gsw_season_log.csv` (game number 10, December 25, 2017).
   What was GSW's real score margin and net rating in that specific
   game? Does it sit above or below the rolling line at that point in
   the season?

## Reflection (submit with your lab)

10. This module substitutes a real, complete single-team season
    (Golden State's 2017-18 regular season) for the textbook's own
    private sixteen-team round-robin league file. Name one real thing
    this substitution lets you compute cleanly (something about GSW
    specifically), and one real thing it structurally cannot give you
    (something the textbook's own dataset could, that this one cannot),
    and explain why, referring back to the hub-and-spoke structure you
    described in question 1.

## Extension (optional, not graded)

Instead of splitting GSW's season into two roughly equal halves, split
it into three real segments (games 1-27, 28-54, 55-82) and recompute
`ORtg`/`DRtg` for each. Does the real defensive erosion this module
found in the second half look gradual across all three segments, or
concentrated in one part of the season?
