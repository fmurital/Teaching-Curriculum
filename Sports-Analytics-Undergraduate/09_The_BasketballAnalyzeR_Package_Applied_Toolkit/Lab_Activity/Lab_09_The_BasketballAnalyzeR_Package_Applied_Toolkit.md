# Lab 9: The BasketballAnalyzeR Package, Applied as One Toolkit

## Before you start

Pull up your own R session with `BasketballAnalyzeR` loaded. Today you
are not learning one new statistical idea, you are learning four new
real functions and using them together, the way a real analyst
actually works: pulling whichever real tool answers the real question
in front of them.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(Pbox)
data(Tbox)
data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
```

## Part 1: Rebuild a real box score from raw play-by-play

```r
out_hou <- TOPboxes(PbP, team = "HOU")
out_hou$Tbox
head(out_hou$Pbox[order(-out_hou$Pbox$PTS), ], 5)
```

**Reflection question 1.** Compare `out_hou$Tbox$PTS` to the real,
full-season `PTS` value for the Rockets in the built-in `Tbox`. They
are very different real numbers. In one or two real sentences, explain
why, using what you know about how `PbP.BDB` is actually built.

## Part 2: Rebuild a second real team and compare

```r
out_team <- TOPboxes(PbP, team = "GSW")
out_team$Tbox
head(out_team$Pbox[order(-out_team$Pbox$PTS), ], 5)
```

**Reflection question 2.** Golden State is the one real team in
`PbP.BDB` with a full real 82-game season behind it. How does the
`GP` value in `out_team$Tbox` compare to what you saw for the
Rockets in Part 1, and what does that real difference confirm about
which games this dataset actually covers for each team?

## Part 3: How evenly is real scoring spread across a roster?

```r
Pbox.sel <- subset(Pbox, Team == "Houston Rockets")
ineq_out <- inequality(Pbox.sel$PTS, nplayers = 8)
ineq_out$Gini
plot(ineq_out)
```

**Reflection question 3.** Rerun this for a different real team of
your choosing. Is your team's real Gini index higher or lower than the
Rockets' real 30.95? Does that match what you expected from how your
team is usually talked about (star-driven versus balanced), or does
it surprise you the way the Rockets-versus-Warriors comparison
surprised me in today's notes?

## Part 4: Build the real league-wide bubble chart yourself

```r
X <- with(Tbox, data.frame(T = Team, P2p = P2p, P3p = P3p, FTp = FTp,
                            AS = P2A + P3A + FTA))
labs <- c("2-point shots (% made)", "3-point shots (% made)",
          "free throws (% made)", "Total shots attempted")
bubbleplot(X, id = "T", x = "P2p", y = "P3p", col = "FTp", size = "AS", labels = labs)
```

**Reflection question 4.** Find your own favorite real team on the
chart. In one real sentence, describe its identity using only the
chart: strong or weak on 2s, strong or weak on 3s, high or low free
throw shooting, and high or low shot volume.

## Part 5: Is a shot a good shot, for this specific real player?

```r
PbP.HOU <- subset(PbP, team == "HOU" & !is.na(shot_distance))
plrys <- c("James Harden", "Chris Paul")
expectedpts(data = PbP.HOU, bw = 10, players = plrys, col.team = "dodgerblue",
            palette = colorRampPalette(c("gray", "black")), col.hline = "red")
```

**Reflection question 5.** Swap in two different real players from a
real team you have real play-by-play access to in this dataset
(Golden State's roster works well, since it has the most real games).
Where do their real curves separate from the real team average the
most, and what real distance range is that?

## Extension (optional)

Put all four parts together into one real paragraph: pick one real
team, and use `TOPboxes()`, `inequality()`, `bubbleplot()`, and
`expectedpts()` together to write a short real scouting profile of
that team, the way a real front-office analyst would open a real
report.
