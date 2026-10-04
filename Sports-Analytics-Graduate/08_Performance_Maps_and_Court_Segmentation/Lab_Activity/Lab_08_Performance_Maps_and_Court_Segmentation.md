# Lab 8: Basketball Performance Maps Based on Court Segmentation

## Before you start

Pull up your own R session with `BasketballAnalyzeR`, `dplyr`, and
`rpart` loaded. Every part of this lab builds on the same real
`PbP.BDB` play-by-play data this course has used since Module 5.

```r
library(BasketballAnalyzeR)
library(dplyr)
library(rpart)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
sh <- subset(PbP, event_type %in% c("shot", "miss") &
               !is.na(converted_x) & !is.na(converted_y) & !is.na(shot_distance))
sh$made <- as.integer(sh$event_type == "shot")
```

## Part 1: Normalize real shot coordinates onto one half-court

```r
d1 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 5.25)^2)
d2 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 88.75)^2)
near1 <- d1 <= d2
sh$x_rel <- ifelse(near1, sh$converted_x - 25, -(sh$converted_x - 25))
sh$y_rel <- ifelse(near1, sh$converted_y - 5.25, 88.75 - sh$converted_y)
sh$angle_deg <- atan2(sh$x_rel, sh$y_rel + 1e-6) * 180 / pi
```

**Reflection question 1.** Why does this lab compute a shot's distance
from whichever real hoop is closer, rather than always measuring from
one fixed real point on the court?

## Part 2: Build your own real sector-based performance map

```r
sh$dist_band <- cut(sh$shot_distance, breaks = c(-1, 4, 14, 22, 100),
                     labels = c("Rim", "Paint", "Mid-range", "Three"))
sh$angle_sector <- cut(sh$x_rel, breaks = c(-100, -8, 8, 100),
                        labels = c("Left", "Center", "Right"))
sh %>% group_by(dist_band, angle_sector) %>%
  summarise(Attempts = n(), FGpct = round(100 * mean(made), 1), .groups = "drop")
```

**Reflection question 2.** Try a narrower angle cutoff (for example,
`-5` and `5` instead of `-8` and `8`). Does the real mid-range
center-versus-side pattern from today's notes hold up, or does it
change with a different real sector definition?

## Part 3: Build the real Golden State shot chart

```r
sh.GSW <- subset(sh, team == "GSW")
p0 <- ggplot2::ggplot()
p_court <- drawNBAcourt(p0, size = 1, col = "gray40", full = FALSE)
p_court + ggplot2::geom_point(data = sh.GSW,
            ggplot2::aes(x = x_rel, y = y_rel, color = factor(made)), alpha = 0.45) +
  ggplot2::coord_fixed()
```

**Reflection question 3.** Pick a different real team available in
this dataset (any team that played Golden State has at least some
real shots present). How does the real density and shape of their
shot chart compare to Golden State's?

## Part 4: Build the real CART model on Cartesian coordinates

```r
cart_xy <- rpart(made ~ x_rel + y_rel, data = sh, method = "class",
                  control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
print(cart_xy)
rpart.plot::rpart.plot(cart_xy, extra = 104)
```

**Reflection question 4.** Find the real split in the printed tree
that separates `x_rel >= -1.95` from `x_rel < -1.95` within the close
range band. In your own real words, what real basketball situation is
this split actually describing?

## Part 5: Build the real CART model on polar coordinates, and compare

```r
cart_polar <- rpart(made ~ shot_distance + angle_deg, data = sh, method = "class",
                     control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
print(cart_polar)
mean(predict(cart_xy, sh, type = "class") == sh$made)
mean(predict(cart_polar, sh, type = "class") == sh$made)
```

**Reflection question 5.** The real polar model used only one split
and still nearly matched the real four-node Cartesian model's
accuracy. Write two or three real sentences arguing for which model
you would actually hand to a coaching staff, and why simplicity or
detail should win in this specific real case.

## Extension (optional)

Add `period` or `remaining_time` as a third real predictor to either
CART model. Does real scoring probability by location change in the
last two minutes of a real period, compared to the rest of the game?
