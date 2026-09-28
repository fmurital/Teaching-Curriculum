# Lab 7: Ball Trajectories and Object Detection

## Before you start

Pull up your own R session with `BasketballAnalyzeR` loaded. Everything
in this lab uses the real `PbP.BDB` dataset, the same real 2017-18
season behind today's lecture, plus the real minimum-speed trajectory
physics we derived together in class.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(PbP.BDB)
```

## Part 1: Build the real shot-distance and outcome dataset yourself

```r
FGA <- subset(PbP.BDB, event_type %in% c("shot", "miss") & !is.na(shot_distance))
FGA$made <- as.integer(FGA$event_type == "shot")
FGA$dist_ft <- as.numeric(as.character(FGA$shot_distance))
FGA <- subset(FGA, !is.na(dist_ft))
nrow(FGA)
```

**Reflection question 1.** How many real field goal attempts came back
with a valid real distance? Compare it to the total real number of
rows in `PbP.BDB`. Why would the two numbers differ this much (think
about what other real event types a play-by-play log records besides
shot attempts)?

## Part 2: Reproduce the real FG% by distance curve

```r
FGA$dist_bucket <- cut(FGA$dist_ft, breaks = seq(0, 34, by = 2), include.lowest = TRUE, right = FALSE)
fg_by_dist <- FGA %>%
  filter(!is.na(dist_bucket)) %>%
  group_by(dist_bucket) %>%
  summarise(n = n(), real_fg_pct = round(100 * mean(made), 1)) %>%
  filter(n >= 100)
print(fg_by_dist, n = Inf)
```

**Reflection question 2.** Where does the real curve fall fastest?
Using today's real minimum-speed trajectory numbers, connect that real
drop to what is physically changing about the required shot at those
real distances.

## Part 3: Compute the real minimum-speed trajectory for your own distance

```r
g <- 9.8
rim_h <- 3.048
release_h <- 2.1336
y_rise <- rim_h - release_h

my_distance_ft <- 21   # pick any real distance you want, in feet
x <- my_distance_ft * 0.3048
theta_min_deg <- 45 + 0.5 * (180 / pi) * atan(y_rise / x)
v_min_ms <- sqrt(g * (x + sqrt(x^2 + y_rise^2)))
v_min_mph <- v_min_ms * 2.23694
c(theta_min_deg = theta_min_deg, v_min_mph = v_min_mph)
```

**Reflection question 3.** Pick a real shot distance not already on
today's six-row table (anywhere from the rim out to half court) and
compute its real theoretical minimum-speed angle and speed yourself.
Where does your real number fall relative to the pattern in today's
table?

## Part 4: The real gap between theory and practice

**Reflection question 4.** Today's notes reported real published
launch angles (55.2 degrees at the free throw line, 64.1 degrees from
three) that are substantially steeper than the real theoretical
minimum-speed angles you can compute in Part 3. In your own words,
using what you know about the rim's real physical size relative to the
ball, explain why a real shooter would deliberately use more speed and
a steeper angle than the physics minimum requires.

## Part 5: Object detection performance, read critically

**Reflection question 5.** This module's real YOLOv8-based ball
detection numbers (Liang et al., 2025) showed a real recall of 83.4%
for the baseline model and 89.7% for the purpose-built BGS-YOLO model,
both lower than their respective real precision numbers (93.1% and
96.9%). In your own words, what does a real system with high precision
but lower recall actually get wrong in practice, and why would that
matter more for a full-game trajectory reconstruction than for a
single highlight clip?

## Extension (optional)

Using the real six-distance trajectory table from class, fit a simple
model (in R, `lm()` or `BasketballAnalyzeR::simplereg()`) of real
theta_min as a function of real distance. How well does a simple
model capture the real, curved relationship you can see in the plot?
