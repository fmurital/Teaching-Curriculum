# Lab 6: Event Density and Shooting Under Pressure

## Before you start

Pull up your own R session with `BasketballAnalyzeR` loaded. I want
you working the real numbers with me, not just reading them off a
slide. Everything in this lab uses the real `PbP.BDB` play-by-play
data, the same dataset behind today's lecture.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
```

## Part 1: Build the event density plot yourself

Run this and look at the shape of the curve, not just the numbers.

```r
FG <- subset(PbP, ShotType %in% c("2P","3P"))
densityplot(data = FG, var = "playlength", shot.type = "field")
```

**Reflection question 1.** Where does the density curve peak? Is
there a second, smaller bump later in the shot clock? What real
basketball behavior do you think produces that second bump?

## Part 2: Recreate the shot-clock pressure table

```r
FG <- FG %>% mutate(
  clock_bucket = case_when(
    playlength < 12 ~ "Early clock",
    playlength < 18 ~ "Mid clock",
    TRUE ~ "Late clock, high pressure"
  )
)
FG %>%
  group_by(clock_bucket) %>%
  summarise(attempts = n(), makes = sum(result == "made", na.rm = TRUE),
            fg_pct = round(100 * mean(result == "made", na.rm = TRUE), 1))
```

**Reflection question 2.** Your numbers should match the lecture
table. Now change the cutoffs to `playlength < 8`, `< 16`, and
`18+`. Does the pattern (efficiency dropping as the clock runs down)
hold up under a different definition of "late," or does it depend on
exactly where you draw the line?

## Part 3: Isolate three-point shooting under pressure

```r
FG3 <- subset(PbP, ShotType == "3P") %>% mutate(
  clock_bucket = case_when(
    playlength < 12 ~ "Early clock",
    playlength < 18 ~ "Mid clock",
    TRUE ~ "Late clock, high pressure"
  )
)
FG3 %>%
  group_by(clock_bucket) %>%
  summarise(attempts = n(), makes = sum(result == "made", na.rm = TRUE),
            fg_pct = round(100 * mean(result == "made", na.rm = TRUE), 1))
```

**Reflection question 3.** Three-point shooting is not worst in the
late-clock bucket alone here; it is worst in early clock and late
clock and best in the middle. Write one real basketball explanation
for why very early three-point attempts might also be lower
percentage shots, not just late ones.

## Part 4: Build the real clutch-time split yourself

```r
PbP2 <- PbP %>% mutate(
  margin = abs(home_score - away_score),
  is_clutch = (period >= 4 & periodTime >= 420 & margin <= 5)
)
FGclutch <- subset(PbP2, ShotType %in% c("2P","3P"))
FGclutch %>%
  group_by(is_clutch) %>%
  summarise(attempts = n(), makes = sum(result == "made", na.rm = TRUE),
            fg_pct = round(100 * mean(result == "made", na.rm = TRUE), 1))
```

**Reflection question 4.** The clutch-time definition I gave you uses
a 5-point margin and the last 5 minutes. Try tightening it to a
3-point margin and the last 3 minutes (`periodTime >= 540`). Does the
sample size still support a meaningful comparison? What happens to a
statistic's reliability when you define "pressure" more narrowly?

## Part 5: Find the real clutch shot-takers

```r
FGclutch %>%
  filter(is_clutch) %>%
  group_by(player) %>%
  summarise(attempts = n(), makes = sum(result == "made", na.rm = TRUE),
            fg_pct = round(100 * mean(result == "made", na.rm = TRUE), 1)) %>%
  filter(attempts >= 5) %>%
  arrange(desc(attempts))
```

**Reflection question 5.** Pick one player from this table. Their
clutch shooting percentage is almost certainly lower than their
overall season shooting percentage. Does that make them a worse
clutch performer, or does it just mean clutch shots are, on average,
harder shots? What additional real data would you want before
deciding which explanation is right?

## Submit

Turn in your R script (or a saved `.R` file) showing all five parts
run with real output, plus written answers to all five reflection
questions.
