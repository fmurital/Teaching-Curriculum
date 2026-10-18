# Assignment 1: Getting Oriented, Pace, Four Factors, and Team Profiles

**Sports Analytics (Undergraduate)** -- covers Modules 1-3 (getting oriented in `BasketballAnalyzeR`, pace and ratings, the Four Factors, and comparison plots).

**Due:** -- set by instructor before posting --

**Total: 100 points (5 problems, 20 points each)**

Work in RStudio using the real 2017-18 NBA season data built into `BasketballAnalyzeR` (`Pbox`, `Tbox`, `Obox`), the same data we have used in class. Unless a problem tells you otherwise, use the Milwaukee Bucks as your team -- a team we have not yet worked with together in Modules 1-3. Submit your `.R` script (or `.Rmd`), any plots as image files, and a short write-up answering each sub-part in full sentences.

## Problem 1 -- Setup and concepts (20 points)

a. (6 pts) In your own words, explain what `pacman::p_load()` does differently from calling `install.packages()` and `library()` separately.
b. (6 pts) Explain what `conflicted::conflict_prefer()` is for, and give one concrete example (not from lecture) of a function name that exists in more than one package you have loaded this semester.
c. (8 pts) In two or three sentences, explain what Pace measures and why two teams can have the same record (win total) while having very different Pace values.

## Problem 2 -- A real scoring leaderboard (20 points)

Using `Pbox`, filter to Milwaukee Bucks players with at least 500 minutes played (`MIN >= 500`) for the 2017-18 season.

a. (10 pts) Compute each player's points per game (PTS/GP) and produce a table ranked from highest to lowest.
b. (6 pts) Report the top scorer and his points-per-game figure.
c. (4 pts) The filter keeps only players with 500+ minutes. Explain, in your own words, why this matters for a fair PPG ranking (your answer should name a specific problem that would occur without the filter).

## Problem 3 -- Four Factors, one team against the league (20 points)

Using `Tbox` and `Obox`, compute the Four Factors (effective field goal percentage, turnover percentage, offensive rebound percentage, and free throw rate), Offensive Rating, Defensive Rating, and Pace for all 30 teams, following the same formulas used in class (`fourfactors()`).

a. (8 pts) Report the Milwaukee Bucks' values for all four factors, Pace, Offensive Rating, and Defensive Rating.
b. (8 pts) Compute the league-average value for each of those seven metrics and state, for each one, whether the Bucks are above or below league average.
c. (4 pts) Based on this comparison, is the Bucks' biggest issue on offense or on defense? Justify your answer using at least one specific number from part (b).

## Problem 4 -- Visualizing the league (20 points)

a. (12 pts) Produce a single scatter plot with every team's Pace on the x-axis and Net Rating (Offensive Rating minus Defensive Rating) on the y-axis. Label the Milwaukee Bucks' point distinctly from the other 29 teams (for example, with a different color or a text label).
b. (8 pts) Looking at your plot, describe the overall relationship (if any) between Pace and Net Rating across the league. Does playing faster appear to make a team better, worse, or does it show no clear relationship?

## Problem 5 -- Reading the numbers correctly (20 points)

In the 2017-18 season, the Golden State Warriors led the entire NBA in points scored per game, while the Houston Rockets had the best Net Rating (Offensive Rating minus Defensive Rating) in the league and the best record (65-17).

a. (8 pts) Does leading the league in points per game necessarily mean a team has the best offense, once Pace is taken into account? Explain why or why not.
b. (12 pts) Compute the correlation between Pace and Wins across all 30 teams, and separately the correlation between Net Rating and Wins. Report both numbers. Then identify which single team in the league had the fastest Pace, and report that team's win total. What does this combination of facts tell you about using points-per-game or Pace alone to judge how good a team is?
