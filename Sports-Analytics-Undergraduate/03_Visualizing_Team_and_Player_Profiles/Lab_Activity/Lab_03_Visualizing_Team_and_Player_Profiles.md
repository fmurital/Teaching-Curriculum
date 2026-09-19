# Lab 3: Visualizing Team and Player Profiles

**Goal:** build standardized player profiles, a bar-line comparison
chart, and a weighted variability diagram, using real data bundled with
`BasketballAnalyzeR`, and use them to answer questions a single-number
stat cannot.

## Setup

Open `Coding_Exercise/module3_visualizing_profiles.R` in RStudio, or
start a fresh script and follow along.

```r
library(BasketballAnalyzeR)
data(Pbox)
data(Tbox)
```

`Pbox` holds real 2017-18 per-player season totals: minutes, makes,
attempts, rebounds, assists, and turnovers, one row per player.

## Part 1: Build five player profiles

```r
stars <- c("Russell Westbrook", "James Harden", "LeBron James",
           "Giannis Antetokounmpo", "Stephen Curry")
P5 <- Pbox[Pbox$Player %in% stars, ]

X <- data.frame(P5$P2M, P5$P3M, P5$OREB + P5$DREB, P5$AST, P5$TOV) / P5$MIN
names(X) <- c("P2M", "P3M", "REB", "AST", "TO")
rownames(X) <- P5$Player
round(X * 36, 2)
```

1. Before standardizing anything, look at the raw per-36-minute table.
   Which player has the highest three-point rate? The highest rebound
   rate?

## Part 2: Standardize by hand, then check it against the package

```r
Z <- as.data.frame(scale(X))
round(Z, 3)
```

`scale()` computes `z = (x - mean(x)) / sd(x)` for every column.

2. Pick any one cell in the z-score table and recompute it by hand from
   the raw per-36 table (`mean()` and `sd()` on that column). Confirm it
   matches.

3. Which player has the most extreme (furthest from 0) single z-score in
   this table, and on which variable? What does that number tell you
   about their role, beyond just "high" or "low"?

## Part 3: The radial profile chart

```r
radialprofile(data = X, title = rownames(X), ncol.arrange = 3)
```

4. `radialprofile()` standardizes internally by default. Compare the
   shape it draws for Giannis Antetokounmpo against the raw and z-score
   tables you already built. Does the shape match the numbers?

5. Radar charts have real critics in professional basketball analytics
   (see the module notes). In one or two sentences, explain one specific
   way someone could misread this chart if they only looked at the shape
   and not the underlying z-scores.

## Part 4: Bar-line plot

```r
dts <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500)
barline(data = dts, id = "Player", bars = c("P2p", "P3p", "FTp"),
        line = "MIN", order.by = "MIN", labels.bars = c("2P%", "3P%", "FT%"),
        title = "Houston Rockets, 2017-18 (MIN >= 500)")
```

6. Order the Rockets players by minutes played. Does more playing time
   line up with higher shooting percentages in this chart, or not? Name
   one player whose shooting percentages do not match the pattern you
   would expect from their minutes.

## Part 5: Weighted variability

```r
Pbox.HR <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500,
                   select = c("Player", "P2p", "P3p", "FTp", "P2A", "P3A", "FTA"))
rownames(Pbox.HR) <- Pbox.HR$Player
vc <- variability(data = Pbox.HR, data.var = c("P2p", "P3p", "FTp"),
                   size.var = c("P2A", "P3A", "FTA"), weight = TRUE)
print(vc)
plot(vc)
```

7. Rank two-point, three-point, and free-throw percentage from most to
   least consistent (lowest to highest coefficient of variation) across
   this roster. Is the ranking what you expected before running the
   code? Propose one basketball explanation for why free-throw shooting
   might vary more across a roster than three-point shooting does, even
   though free throws are uncontested.

## Part 6: Team profiles

```r
TT <- data.frame(Team = Tbox$Team,
                  AST_pg = round(Tbox$AST / Tbox$GP, 1),
                  TOV_pg = round(Tbox$TOV / Tbox$GP, 1),
                  W = Tbox$W)
cor(TT$AST_pg, TT$W)
cor(TT$TOV_pg, TT$W)
scatterplot(TT, data.var = c("AST_pg", "TOV_pg"), labels = TT$Team, z.var = "W")
```

8. Compare these two correlations (assists-per-game with wins, and
   turnovers-per-game with wins) to net rating's 0.96 correlation with
   wins from Module 2. What does that comparison tell you about how much
   a team's passing style, by itself, explains its win total?

## Reflection (submit with your lab)

9. In your own words: what does standardizing a variable (turning it
   into a z-score) let you do that you cannot do with the raw numbers
   alone? Use one specific example from this lab.

## Extension (optional, not graded)

Pick five players of your own choosing from `Pbox` (any team, any
position), build the same per-36 profile table, standardize it, and
draw a `radialprofile()` chart. Write two sentences describing what the
resulting shapes tell you about each player's role.
