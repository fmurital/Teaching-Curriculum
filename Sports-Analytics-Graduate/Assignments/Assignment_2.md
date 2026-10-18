# Assignment 2: Season Segments, Spatial Patterns, and Reading Real Model Output

**Sports Analytics (Graduate)** -- covers Modules 4-6 (season segments and final rankings, spatial dynamics and tracking data, athletic motion and pose estimation).

**Due:** -- set by instructor before posting --

**Total: 100 points (4 problems, 25 points each)**

This assignment works directly with real output your own modules have already produced this semester -- `module4_adjrtg_two_segments.csv` and `module6_fatigue_window_fg_pct.csv`, both in the Golden State Warriors' real 2017-18 data. Reading and correctly interpreting real output you did not personally generate is itself a core graduate skill, since most data you will work with professionally was not computed by you.

## Problem 1 -- Concepts (20 points)

a. (10 pts) In your own words, explain why splitting a season into two halves and computing adjusted ratings for each (rather than one single season-long average) can reveal something a season-long average hides. Give one concrete basketball reason a team's true level might change partway through a season.
b. (10 pts) Module 6 defines "fatigue" operationally through observable, countable proxies (shooting percentage in a late-game window, turnover rate) rather than through a direct physiological measurement. Explain one advantage and one real limitation of defining fatigue this way.

## Problem 2 -- Reading real season-segment output (25 points)

Open `module4_adjrtg_two_segments.csv` and find Golden State's row.

a. (10 pts) Report Golden State's raw Offensive Rating and Defensive Rating in each of the two season segments (41 games each).
b. (10 pts) Golden State's Offensive Rating barely moved between segments (111.89 to 112.26), but their Defensive Rating changed more (102.03 to 106.79). In two or three sentences, what does this specific pattern suggest about where Golden State's team-level change across the season actually came from?
c. (5 pts) This file reports adjusted ratings (columns `AORtg`/`ADRtg`) as 0 for Golden State specifically, while other teams in the same file show real nonzero adjusted values. Propose one specific, reasonable explanation for why Golden State's adjustment would come out to exactly zero in this dataset (hint: think about what "adjusted" usually means relative to, and how much of this particular dataset Golden State itself makes up).

## Problem 3 -- Reading real fatigue-window output (30 points)

Open `module6_fatigue_window_fg_pct.csv`.

a. (10 pts) Report the real field goal percentage and sample size (number of shot attempts, `n`) for each of the three segments in the file.
b. (10 pts) The "Last 3 min of Q4" segment shows a real field goal percentage of 44.7% on 873 shots, compared to 47.6% on 13,450 shots for the rest of the game. Is a gap of under 3 percentage points, on a sample of 873 shots, strong evidence of a real fatigue (or pressure) effect, or is it the kind of gap you would expect to see from chance alone in a sample this size? Justify your answer using what you know about how sample size affects the reliability of an observed percentage.
c. (10 pts) The "Overtime" segment shows 59.4% on only 32 shots -- the highest field goal percentage of the three segments. Explain specifically why this number is much less trustworthy than the other two, and what you would need (more of) before using it to argue that players shoot better in overtime.

## Problem 4 -- A graduate-level synthesis (25 points)

a. (15 pts) Using your answers to Problems 2 and 3, write a short (4-6 sentence) real, evidence-based summary of what this semester's real Golden State data does and does not support about in-season fatigue and late-game performance. Your summary should explicitly distinguish between a finding you consider reasonably well-supported by the sample size involved, and one you consider suggestive at best.
b. (10 pts) A front-office analyst reads only the headline numbers (44.7% late-game vs. 47.6% overall) and recommends resting starters more in the final three minutes of comfortable wins to "preserve their shooting touch." Identify one real methodological problem with drawing that specific recommendation directly from this one number, referencing something you discussed in Problem 3.
