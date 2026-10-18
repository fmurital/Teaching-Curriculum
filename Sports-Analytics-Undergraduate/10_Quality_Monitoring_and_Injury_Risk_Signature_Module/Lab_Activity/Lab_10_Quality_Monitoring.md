# Lab 10: Build Your Own Control Chart on a Real NBA Workload Signal

## What you need

Open RStudio and load the real 2023-24 NBA shot log the same way we did in class. I have put a trimmed version of it, along with the script I used to build today's chart, in this module's `Coding_Exercise` folder.

```r
shots <- read.csv("shotdetail_2023.csv", stringsAsFactors = FALSE)
```

## Step 1: Pick your own real player

In class I used Joel Embiid. Today I want you to pick a different real player from the 2023-24 season, someone who played enough games to make this meaningful, at least 40 real games. Filter the data down to your player.

```r
player_shots <- shots[shots$PLAYER_NAME == "your chosen player", ]
```

## Step 2: Build your player's real per-game workload series

Aggregate your player's real shot attempts, game by game, in chronological order by `GAME_DATE`. This is the same real move I made in class: counting every real shot attempt your player took in every real game, in the order those games actually happened.

```r
by_game <- aggregate(SHOT_ATTEMPTED_FLAG ~ GAME_ID + GAME_DATE, data = player_shots, FUN = sum)
names(by_game)[3] <- "FGA"
by_game <- by_game[order(by_game$GAME_DATE), ]
```

## Step 3: Compute your own real control limits

Using the same real formulas from class, compute your player's real center line, average moving range, estimated standard deviation, and upper and lower control limits.

```r
xbar <- mean(by_game$FGA)
mr_bar <- mean(abs(diff(by_game$FGA)))
sigma_hat <- mr_bar / 1.128
UCL <- xbar + 3 * sigma_hat
LCL <- max(0, xbar - 3 * sigma_hat)
```

## Step 4: Find the real signals

Identify every real game where your player's field goal attempts broke either control limit.

```r
out_of_control <- by_game[by_game$FGA > UCL | by_game$FGA < LCL, ]
print(out_of_control)
```

## Step 5: Plot it

Build your own real version of the chart from class: your player's real game-by-game attempts, the center line, and both control limits, plotted in order.

## Reflection questions

1. How many real out-of-control games did your player have across the season? Does that number surprise you, given how many total games they played?
2. Look up whether your player missed any real games to injury that season, using any legitimate public source. Did any real out-of-control game in your chart happen in the weeks before a real missed-game stretch? Be honest if the answer is no, that is useful information too.
3. A single statistical outlier is not proof of anything on its own. What is one other piece of real information, beyond the shot-attempt count alone, that an NBA team's sports science staff would want before treating one of your flagged games as a real concern?
4. This lab used field goal attempts as a stand-in for workload. Name one other real, available basketball statistic that could serve as a workload signal instead, and explain in one sentence why it might catch something attempts alone would miss.
5. Go back to the ACWR critique from today's reading. If your team's training staff asked you to build an ACWR-based alert system instead of a control chart, what is the first real statistical weakness from the Kanwal et al. review you would raise with them, and why?

## What to turn in

Your R script, your output table of out-of-control games, your chart, and written answers to all five reflection questions.
