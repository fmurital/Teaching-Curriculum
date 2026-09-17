# Lab 1 (Guided): Environment Setup and a First Look at Real NBA Data

## Learning Objectives

By the end of this lab, you will be able to install and load the `BasketballAnalyzeR` package, describe the structure of its two core datasets, and compute a simple, honest summary statistic from real NBA data.

## Dataset

`BasketballAnalyzeR` bundles real, anonymized-free NBA 2017-18 regular season data. This lab uses two of its tables:

- `Pbox`: one row per player (605 players, 22 variables), player-level box score totals for the season.
- `Tbox`: one row per team (30 teams, 23 variables), team-level box score totals for the season.

No data is copied into this repository. You load it directly from the package with `data(Pbox)` and `data(Tbox)`, exactly as the course textbook does.

## Instructions

1. Install R and RStudio if you have not already (both free). Confirm RStudio opens and shows a console.
2. Install the course package: `install.packages("BasketballAnalyzeR")`. This installs `ggplot2` as a dependency if you do not already have it.
3. Run `library(BasketballAnalyzeR)`. You should see a message about `RNGkind(sample.kind = "Rounding")`. This message tells you the package can reproduce the exact figures in the course textbook. You do not need that setting for this lab, but remember it is there for later modules that replicate a textbook figure exactly.
4. Load the two datasets with `data(Pbox)` and `data(Tbox)`.
5. Check the shape of each table with `dim(Pbox)` and `dim(Tbox)`. Confirm you get 605 rows and 22 columns for `Pbox`, and 30 rows and 23 columns for `Tbox`.
6. Run `names(Tbox)` and read through the column names. Several of these (`P2M`, `P2A`, `P3M`, `P3A`, `FTM`, `FTA`) will come back in Module 2 when we compute the Four Factors.
7. Add a new column to `Tbox` for points per game: `Tbox$PPG <- round(Tbox$PTS / Tbox$GP, 1)`.
8. Sort the table by `PPG` in descending order and print the top 5 teams, keeping only the `Team`, `GP`, `W`, `L`, and `PPG` columns.
9. Build a horizontal bar chart of every team's win total for the season, sorted from fewest to most wins, using `ggplot2`. The full working script is provided in `Coding_Exercise/module1_first_look.R` if you want to check your work, but try steps 7 through 9 yourself first.

## Guidance

If `install.packages("BasketballAnalyzeR")` fails, check that your R version is current (R 4.x) and that you have an internet connection RStudio can reach. If a specific dependency fails to install, install that package by name first, then retry.

`Tbox$Team` is stored as a character column until you convert it. To control the order teams appear in a `ggplot2` bar chart, convert it to a factor first with `factor(Tbox$Team, levels = Tbox$Team[order(Tbox$W)])`, as shown in the coding exercise script.

## Reflection Questions

1. `Pbox` has 605 rows and `Tbox` has 30 rows, for the same single NBA season. What does the difference in row counts tell you about what each table actually records?
2. Points per game is a purely descriptive statistic. What is one question about team quality that points per game cannot answer by itself, and why?
3. Which team had the most wins in the 2017-18 season according to your chart? Does that match what you already knew or expected, or does it surprise you?

## Extensions

If you finish early, compute each team's average margin of victory using `Tbox$W`, `Tbox$L`, and `Tbox$PTS` together with the opponent scoring table `Obox` (also bundled with the package), and see whether the team with the most wins also has the largest average margin.
