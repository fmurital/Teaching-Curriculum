# Midterm Project: A Full Team Profile, Graduate Level

**Sports Analytics (Graduate)** -- draws on Modules 1-5 (getting started with advanced basketball analytics, lineups and combinations, clutch performance and situational splits, season segments and final rankings, spatial dynamics and tracking data).

**Due:** -- set by instructor before posting --

**Total: 100 points**

## Assignment

Pick one real NBA team from the 2017-18 season (`Tbox`, `Obox`, `Pbox`) that you have not already used in Assignment 1, 2, or 3 this semester. Produce a written team profile report (roughly 4-6 pages, including your tables and plots) that goes further than the undergraduate course's parallel midterm: in addition to a full statistical profile, you must build and evaluate your own real predictive model and explicitly reason about its limitations. Your report must include all of the following sections, clearly labeled:

### 1. Scoring overview (10 points)

Using `Pbox`, filter your team's players to those with at least 500 minutes played, compute points per game, and present a ranked table. Identify the leading scorer.

### 2. Four Factors profile (20 points)

Compute your team's Four Factors, Pace, Offensive Rating, and Defensive Rating, and compare each to the real league average. Identify the team's clearest strength and clearest weakness.

### 3. A real predictive model, and an honest evaluation of it (30 points)

Fit a regression predicting win total from Net Rating (Offensive Rating minus Defensive Rating) across all 30 teams, and use it to predict your chosen team's win total. Report the model's R-squared, your team's predicted win total, and its actual win total. Then, drawing on what Assignment 1 showed about model specification, explain in a paragraph what this one-predictor model does and does not capture about your team specifically (for example, name one real factor about your team's season -- injuries, a trade, a coaching change, a difficult closing schedule -- that a single season-long Net Rating number cannot represent).

### 4. A visual comparison (20 points)

Produce one plot comparing your team to the rest of the league on two metrics of your choosing, with your team clearly highlighted, and interpret what it shows.

### 5. A methodological reflection (20 points)

In a short paragraph, discuss one real data-quality or sample-size issue you encountered or would need to watch for if you extended this analysis using the real play-by-play sample (`PbP.BDB`) rather than the season-level box score data (`Tbox`/`Obox`/`Pbox`) -- for example, what would and would not be reliable to compute about your chosen team from that dataset, given what we learned in Module 3 about how that dataset is actually built.

## Format

Submit your `.R` script (or `.Rmd`) separately from your written report. The report should read as a coherent, professional analysis, not a list of disconnected answers.
