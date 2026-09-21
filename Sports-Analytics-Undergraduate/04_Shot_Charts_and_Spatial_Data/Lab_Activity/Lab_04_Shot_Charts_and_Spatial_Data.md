# Lab 4: Shot Charts and Spatial Data

**Goal:** build real shot charts from real 2018 NBA playoff play-by-play
data, break shot selection into distance zones, and compare shot
profiles across two real teams and two real players.

## Setup

Open `Coding_Exercise/module4_shot_charts.R` in RStudio, or start a
fresh script and follow along.

```r
library(BasketballAnalyzeR)
library(dplyr)
library(ggplot2)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
```

`PbP.BDB` holds real, event-level play-by-play data for the entire 2018
NBA playoffs: 82 games, every team that qualified, one row per event.

## Part 1: Build shot-level coordinates

`shotchart()` expects half-court coordinates centered on the basket,
with y always zero or negative. The raw `converted_x`/`converted_y`
columns are full-court coordinates, so shots taken at the far basket
need to be folded onto the same half-court view.

```r
shots <- PbP %>%
  filter(event_type %in% c("shot", "miss")) %>%
  mutate(cx = as.numeric(as.character(converted_x)),
         cy = as.numeric(as.character(converted_y)),
         made = ifelse(event_type == "shot", 1L, 0L),
         result2 = factor(ifelse(event_type == "shot", "made", "missed"),
                           levels = c("made", "missed")),
         dist = as.numeric(as.character(shot_distance))) %>%
  filter(!is.na(cx), !is.na(cy)) %>%
  mutate(yc = ifelse(cy <= 47, cy - 47, 47 - cy),
         xc = ifelse(cy <= 47, cx - 25, 25 - cx))
```

1. In your own words, why does a shot taken near the far basket need its
   x and y coordinates transformed differently than a shot taken near
   the near basket?

## Part 2: A real team shot chart

```r
hou <- shots %>% filter(team == "HOU")
shotchart(data = hou, x = "xc", y = "yc", z = "result2", scatter = TRUE)
```

2. Describe, in one or two sentences, where Houston's makes and misses
   cluster on the floor. Is there an area of the half-court that is
   nearly empty?

## Part 3: Distance zones

```r
shots <- shots %>%
  mutate(zone = case_when(
    dist <= 4  ~ "Rim (0-4 ft)",
    dist <= 14 ~ "Short/Mid (5-14 ft)",
    dist <= 21 ~ "Long Two (15-21 ft)",
    TRUE       ~ "Three (22+ ft)"
  ))

league_zone <- shots %>% group_by(zone) %>%
  summarise(attempts = n(), fgpct = round(100*mean(made),1)) %>%
  mutate(share = round(100*attempts/sum(attempts),1))
print(league_zone)
```

3. Which zone has the smallest share of all real 2018 playoff attempts?
   Which has the highest real field goal percentage? Are they the same
   zone?

## Part 4: Two real teams, side by side

```r
zone_tab <- shots %>% filter(team %in% c("HOU","CLE")) %>%
  group_by(team, zone) %>%
  summarise(attempts = n(), fgpct = round(100*mean(made),1),
            pps = round(mean(ifelse(made==1, ifelse(zone=="Three (22+ ft)",3,2), 0)),2)) %>%
  group_by(team) %>% mutate(share = round(100*attempts/sum(attempts),1))
print(zone_tab)
```

4. Add up Houston's rim share and three-point share from your output.
   What percentage of every Houston shot in this data came from one of
   those two zones? Do the same for Cleveland. Which team's shot
   selection more closely matches the "avoid the long two" pattern
   described in the module notes?

## Part 5: Two real players

```r
harden <- shots %>% filter(team=="HOU", player=="James Harden")
lebron <- shots %>% filter(team=="CLE", player=="LeBron James")
shotchart(data = harden, x = "xc", y = "yc", z = "result2", scatter = TRUE)
shotchart(data = lebron, x = "xc", y = "yc", z = "result2", scatter = TRUE)
```

5. Compute each player's rim field goal percentage from the zone table
   (Part 4's code, filtered to one player). LeBron James shot a real
   87.5% at the rim in this sample. Propose one basketball reason a
   player might shoot that much better than average from the rim zone
   specifically.

## Reflection (submit with your lab)

6. In your own words: why is "field goal percentage" alone not enough
   to describe a player's shot selection, even though it is a real and
   accurate number? Use one specific example from this lab.

## Extension (optional, not graded)

Pick one more real 2018 playoff team from `PbP.BDB` (check
`unique(shots$team)` for the full list) and build its own zone table and
shot chart. Write two sentences comparing that team's shot profile to
Houston's.
