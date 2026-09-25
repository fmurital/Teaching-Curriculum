# Lab 5: Understanding Players' Spatial Dynamics

## Before you start

Open your own R session with `BasketballAnalyzeR`, `deldir`, `MASS`,
`dplyr`, and `ggplot2` loaded. Everything in this lab uses real shot
locations from `PbP.BDB`, the same dataset behind today's lecture.

```r
library(BasketballAnalyzeR); library(dplyr); library(deldir); library(MASS); library(ggplot2)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
shots <- subset(PbP, ShotType %in% c("2P","3P") & !is.na(original_x) & !is.na(original_y))
shots$x_ft <- shots$original_x / 10
shots$y_ft <- shots$original_y / 10
```

## Part 1: Build a real convex hull yourself

Pick a real GSW player other than Curry or Green (check
`Coding_Exercise/module5_gsw_player_shot_counts.csv` for who has
enough real volume) and build their real shot-territory hull.

```r
player_shots <- shots %>% filter(team == "GSW", player == "Kevin Durant")
h <- chull(player_shots$x_ft, player_shots$y_ft)
hull_pts <- player_shots[h, c("x_ft","y_ft")]
ggplot() +
  geom_point(data = player_shots, aes(x_ft, y_ft), alpha = 0.4) +
  geom_polygon(data = hull_pts, aes(x_ft, y_ft), fill = "steelblue", alpha = 0.2, color = "steelblue") +
  coord_fixed()
```

**Reflection question 1.** Compare your player's real hull shape and
area to Curry's (2,538 sq ft) and Green's (2,264 sq ft) from lecture.
Does your player's real role on the floor match what the hull's shape
and size suggest?

## Part 2: Rebuild the real Voronoi tessellation

```r
top_gsw <- shots %>% filter(team == "GSW") %>% count(player, sort = TRUE) %>% filter(n >= 100) %>% pull(player)
jumpers <- shots %>% filter(team == "GSW", player %in% top_gsw, ShotType == "3P" | x_ft^2 + y_ft^2 > 10^2)
centroids <- jumpers %>% group_by(player) %>% summarise(cx = median(x_ft), cy = median(y_ft), n = n())
vt <- deldir(centroids$cx, centroids$cy, rw = c(-25, 25, -2, 47))
plot(vt, wlines = "tess")
points(centroids$cx, centroids$cy, pch = 19, col = "red")
```

**Reflection question 2.** Which two real players get the largest
Voronoi regions? Why does a player's real region size depend on how
far their real median shooting location sits from their teammates',
not just on how many real shots they take?

## Part 3: Change the exclusion radius

The lecture's Voronoi map excluded real shots within 10 feet of the
basket before computing each player's median location.

```r
jumpers15 <- shots %>% filter(team == "GSW", player %in% top_gsw, x_ft^2 + y_ft^2 > 15^2)
centroids15 <- jumpers15 %>% group_by(player) %>% summarise(cx = median(x_ft), cy = median(y_ft), n = n())
```

**Reflection question 3.** Rerun the tessellation with a 15-foot
exclusion radius instead of 10. Do the same two players still get the
largest regions? What does it mean if the map is sensitive to this
choice?

## Part 4: Build your own real kernel density comparison

```r
p1 <- shots %>% filter(team == "GSW", player == "Klay Thompson")
p2 <- shots %>% filter(team == "GSW", player == "Zaza Pachulia")
kd1 <- kde2d(p1$x_ft, p1$y_ft, n = 100, lims = c(-25,25,0,47))
kd2 <- kde2d(p2$x_ft, p2$y_ft, n = 100, lims = c(-25,25,0,47))
```

**Reflection question 4.** Without plotting, predict in one sentence
each what you expect Klay Thompson's and Zaza Pachulia's real density
shapes to look like, based on what you know about their real roles.
Then plot both and check yourself.

## Part 5: Connect this to gravity, honestly

**Reflection question 5.** This module could not compute the NBA's
real, official Gravity stat, because that stat needs real frame-by-frame
optical tracking data this course does not have access to. Using only
what this lab's real hull-area and Voronoi results show, write two or
three sentences arguing whether Stephen Curry's real shot-location data
alone is enough to support the claim that he has high real "gravity,"
or whether that claim genuinely requires the tracking data we do not
have.

## Submit

Turn in your R script showing all five parts with real output, your
new player's hull plot, both Voronoi variants, your predicted-versus-
actual kernel density plots, and written answers to all five
reflection questions.
