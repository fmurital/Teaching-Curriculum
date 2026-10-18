# Lab 6: Athletic Motion Kinematics Analysis

## Before you start

Pull up your own R session with `BasketballAnalyzeR` and `dplyr` loaded. Today you are working with the same real 2017-18 Golden State Warriors play-by-play log behind Modules 4 and 5, but asking a new kind of question: does anything in this real data behave the way fatigue-driven mechanical breakdown would predict.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
```

## Part 1: Build the real free throw dataset

```r
ft <- subset(PbP, event_type == "free throw" & !is.na(result))
ft$make <- ifelse(ft$result == "made", 1, 0)
nrow(ft)
```

**Reflection question 1.** Before you run anything else, write down your own prediction: do you expect real free throw percentage to decline from Q1 to Q4? Give one real basketball reason for your prediction, not just a guess.

## Part 2: Real free throw percentage by quarter

```r
ft_period <- ft %>%
  filter(period <= 4) %>%
  group_by(period) %>%
  summarise(attempts = n(), pct = round(100 * mean(make), 1), .groups = "drop")
print(ft_period)
```

**Reflection question 2.** Compare your Part 1 prediction to the real numbers you just produced. Were you right? If not, propose one real, testable reason the data might not show the pattern you expected (for example: does removing low-volume shooters change the picture? Try filtering to players with at least 40 real attempts and rerunning the by-period breakdown for just those players).

## Part 3: One real player, isolated

```r
curry_ft <- ft %>% filter(player == "Stephen Curry", period <= 4) %>%
  group_by(period) %>%
  summarise(attempts = n(), pct = round(100 * mean(make), 1), .groups = "drop")
print(curry_ft)
```

**Reflection question 3.** Pick a second real player from `unique(ft$player)` with at least 40 real attempts and rerun this same by-period breakdown for them. Does their real pattern look like Curry's, or different? What is one real reason two players' shot mechanics might respond differently to a long game?

## Part 4: Real turnover rate by quarter

```r
plays_period <- PbP %>% filter(period <= 4) %>% group_by(period) %>% summarise(plays = n(), .groups = "drop")
tov_period <- PbP %>% filter(event_type == "turnover", period <= 4) %>% group_by(period) %>% summarise(turnovers = n(), .groups = "drop")
tov_rate <- merge(plays_period, tov_period, by = "period")
tov_rate$tov_per_100_plays <- round(100 * tov_rate$turnovers / tov_rate$plays, 2)
print(tov_rate)
```

**Reflection question 4.** This module's notes point out that a flat, non-declining trend is itself a meaningful finding, not a failed analysis. In your own words, explain why. What would you need, that this dataset does not have, to actually test whether a specific player's crossover mechanics degrade late in games?

## Part 5: The real late-game fatigue window

```r
late <- subset(PbP, event_type %in% c("shot","miss") & period == 4 & periodTime >= 540)
late$make <- ifelse(late$event_type == "shot", 1, 0)
rest  <- subset(PbP, event_type %in% c("shot","miss") & !(period == 4 & periodTime >= 540) & period < 5)
rest$make <- ifelse(rest$event_type == "shot", 1, 0)
cat("Last 3 min of Q4:", round(100*mean(late$make),1), "% (n=", nrow(late), ")\n")
cat("Rest of game:", round(100*mean(rest$make),1), "% (n=", nrow(rest), ")\n")
```

**Reflection question 5.** The real gap here is about 3 percentage points. Name one real confound (something other than the shooter's own fatigue) that could produce part of this gap, and explain briefly how you would try to control for it if you had more time and more real data.

## Part 6: Connecting to the real published literature

Read the summaries of Wei et al. (2025) and Li et al. (2026) in this module's notes and References file.

**Reflection question 6.** Both studies found that markerless pose estimation agrees well with lab-grade marker-based systems for some measurements (ankle and knee position, joint displacement) and less well for others (hip angle, velocity, acceleration). If you were designing a real study to check whether a player's crossover dribble mechanics predict injury risk, which specific real joint or quantity from these two studies would you trust least, and what would you do about it in your study design?
