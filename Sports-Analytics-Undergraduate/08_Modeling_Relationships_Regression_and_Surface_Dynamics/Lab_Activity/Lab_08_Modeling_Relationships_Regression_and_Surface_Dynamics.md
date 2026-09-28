# Lab 8: Modeling Relationships, Regression and Surface Area Dynamics

## Before you start

Pull up your own R session with `BasketballAnalyzeR` loaded. I want
you fitting these real models with me, not just reading the fitted
lines off a slide. Everything in this lab uses the real `Pbox`,
`Tbox`, and `Obox` datasets, the same 2017-18 season behind today's
lecture.

```r
library(BasketballAnalyzeR)
library(dplyr)
data(Pbox)
data(Tbox)
data(Obox)
```

## Part 1: Build the real team regression yourself

```r
FF <- fourfactors(Tbox, Obox)
NetRtg <- FF$ORtg - FF$DRtg
mod_lin <- simplereg(x = NetRtg, y = Tbox$W, type = "lin")
plot(mod_lin, xlab = "Net Rating", ylab = "Real Wins")
summary(mod_lin$Model)
```

**Reflection question 1.** What real R-squared did you get? Find your
own team, or a team you follow, in this real dataset. Is its real win
total above or below what the fitted line would predict from its real
Net Rating? What might explain that real gap (injuries, close-game
luck, schedule strength) that a single-variable model cannot capture?

## Part 2: Compare a straight line against a curve

```r
mod_pol <- simplereg(x = NetRtg, y = Tbox$W, type = "pol")
mod_pol$R2
```

**Reflection question 2.** The real curved fit raised R-squared from
0.9133 to 0.9527. Is that real improvement big enough, in your own
judgment, to justify a more complicated model over the simple straight
line? Defend your answer using the real numbers, not a general opinion
about curves being "better."

## Part 3: Build the real assist-turnover regression

```r
Pbox.sel <- subset(Pbox, MIN >= 500)
X <- Pbox.sel$AST / Pbox.sel$MIN
Y <- Pbox.sel$TOV / Pbox.sel$MIN
Pl <- Pbox.sel$Player
mod <- simplereg(x = X, y = Y, type = "lin")
plot(mod, xlab = "Assists per minute", ylab = "Turnovers per minute")
```

**Reflection question 3.** Pick two real players from the output who
have a similar real assist rate but a noticeably different real
turnover rate (Chris Paul and James Harden are one real pair from
today's lecture; find your own second pair). What does the real gap
between them tell you that the regression line by itself cannot?

## Part 4: Build the real "surface area" variability diagram

```r
Pbox.BC <- subset(Pbox, Team == "Houston Rockets" & MIN >= 500,
                   select = c("Player","P2p","P3p","FTp","P2A","P3A","FTA"))
list_variability <- variability(data = Pbox.BC, data.var = c("P2p","P3p","FTp"),
                                 size.var = c("P2A","P3A","FTA"), weight = TRUE)
plot(list_variability, leg.brk = c(10, 25, 50, 100, 500, 1000), max.circle = 30)
```

**Reflection question 4.** Which real bubble is largest on your
chart? Try swapping `Team == "Houston Rockets"` for a different real
team of your choosing and rerun this part. Does the same shooting
split still produce the real largest bubble on a different roster, or
does it change?

## Part 5: Build the real correlation network

```r
data_permin <- data.frame(Pbox$PTS, Pbox$P3M, Pbox$P2M,
                           Pbox$OREB + Pbox$DREB, Pbox$AST,
                           Pbox$TOV, Pbox$STL, Pbox$BLK) / Pbox$MIN
names(data_permin) <- c("PTS","P3M","P2M","REB","AST","TOV","STL","BLK")
data_permin <- subset(data_permin, Pbox$MIN >= 500)
out_corr <- corranalysis(data_permin, threshold = 0.5)
plot(out_corr, layout = "circle")
```

**Reflection question 5.** The real correlation between assists and
turnovers (0.687) was the strongest real off-diagonal pair in this
matrix. Using everything from Parts 1 through 4 of this lab, write two
or three real sentences connecting that correlation back to what you
found in Part 3 about Chris Paul and James Harden specifically.

## Extension (optional)

Try `type = "ks"` (kernel smoothing) instead of `"lin"` or `"pol"` in
`simplereg()` for the assist-turnover relationship. How does the real
fitted curve compare to the other two?
