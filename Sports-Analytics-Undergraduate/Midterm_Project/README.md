# Midterm Project: A Full Team Profile

**Sports Analytics (Undergraduate)** -- draws on Modules 1-5 (getting oriented in `BasketballAnalyzeR`, pace and ratings, the Four Factors, comparison plots, shot charts, correlation and player networks).

**Due:** -- set by instructor before posting --

**Total: 100 points**

## Assignment

Pick one real NBA team from the 2017-18 season (`Tbox`, `Obox`, `Pbox`, `PbP.BDB`) that you have not already used in Assignment 1 or Assignment 2 this semester. Produce a written team profile report (roughly 3-5 pages, including your tables and plots) that brings together everything from Modules 1-5. Your report must include all of the following sections, each clearly labeled:

### 1. Scoring overview (15 points)

Using `Pbox`, filter your team's players to those with at least 500 minutes played, compute points per game for each, and present a ranked table. Identify the team's leading scorer.

### 2. Four Factors profile (25 points)

Compute your team's Four Factors (eFG%, TOV%, ORB%, FT Rate), Pace, Offensive Rating, and Defensive Rating. Compare each of the seven numbers to the real 2017-18 league average, stating clearly whether your team is above or below average on each one, and identify whether the team's bigger strength (or weakness) is on offense or defense.

### 3. A visual comparison (20 points)

Produce one plot comparing your team to the rest of the league on two of the metrics above (for example, Pace vs. Net Rating, or eFG% vs. TOV%), with your team clearly highlighted. Interpret what the plot shows about where your team sits relative to the league.

### 4. A real shot chart (20 points)

Choose one player from your team who appears in the `PbP.BDB` play-by-play sample. Report his total field goal attempts in the sample, his overall field goal percentage, and a breakdown by at least three shot-distance zones. Describe his shot profile in a few sentences: where does he shoot most, and where is he most efficient?

### 5. Prediction and interpretation (20 points)

Using a simple regression of wins on Offensive Rating and Defensive Rating fit across all 30 teams (the same approach used in Assignment 3), predict your team's win total from its real Offensive and Defensive Rating, and compare that prediction to the team's actual 2017-18 win total. If the prediction is close, say so and explain why that is a meaningful result; if it is not close, propose one specific, real-basketball reason for the gap.

## Format

Submit your `.R` script (or `.Rmd`) separately from your written report. The report itself should read as a coherent profile, not a list of disconnected answers -- write complete sentences, and reference your own tables and plots by name or number.
