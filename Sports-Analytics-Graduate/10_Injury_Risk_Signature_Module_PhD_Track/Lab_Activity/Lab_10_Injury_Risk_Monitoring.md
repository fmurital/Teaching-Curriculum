# Lab 10: Building Your Own Injury Risk Monitoring Chart

Today you are going to reproduce, step by step, the live demonstration I ran in class, then extend it to a real case of your own choosing. By the end of this lab you will have built a real, individualized, EWMA-style monitoring chart from scratch, on real NBA data, and reflected honestly on what it did and did not catch.

## What you need

- R, with base packages only (no special installs required for the core exercise).
- The real 2025-26 NBA shot log, available at `https://raw.githubusercontent.com/shufinskiy/nba_data/main/datasets/shotdetail_2025.tar.xz`. Download it, extract it, and you will have `shotdetail_2025.csv`.
- The starter script in `Coding_Exercise/module10_injury_risk_monitoring.R`, which reproduces my own Wembanyama example exactly.

## Part 1: Reproduce my real result

1. Run `Coding_Exercise/module10_injury_risk_monitoring.R` yourself, start to finish. Confirm you get the same real baseline mean and standard deviation I reported in class (mean FGA = 18.18, sd = 4.71, from his first eleven real games).
2. Confirm your own run reproduces the same real result: no pre-injury signal above the |EWMA| > 1.0 threshold before his real November 14, 2025 injury game.
3. In your own words, write two or three real sentences explaining why this is not a failure of the method, using the Wainwright-versus-Alzolay distinction from lecture.

## Part 2: Pick your own real player and real case

1. From the same real `shotdetail_2025.csv` file, pick a different real player who missed real games to injury during the 2025-26 season. You can find real candidates by searching for "[team name] injury report 2025-26" or checking a site like Spotrac's real injury tracker.
2. Adapt the starter script: change the player name filter, find their real injury date from a real news source, and recompute their real baseline, standardized series, and EWMA statistic exactly the way the script does for Wembanyama.
3. Produce your own real chart (a PNG, following the same style as the starter script's plot).
4. Does your real chart signal before your chosen player's real injury date, after it, or not at all? Report the real game number of any first signal and the real lead time in games, the same way I did in class.

## Part 3: Think like a reviewer

1. Both signature papers for this module report real, honest, imperfect sensitivity and specificity. If you were peer-reviewing a paper that applied this same method to your Part 2 player and reported only a successful result, without the paper's own explicit limitations section, what would you ask the authors to add?
2. Pick one specific, concrete extension from the "Where you could take this" section of your Student Notes. Write a real, one-paragraph sketch of how you would test it: what real data source, what real comparison, and what would count as a real, honest success versus a real, honest failure.

## Reflection questions

1. What is the single biggest difference between how this module's EWMA-CUSUM hybrid builds its baseline and how the undergraduate-level I-MR chart example (a simpler, single-player-only baseline) builds its own?
2. The basketball paper's testing-season specificity for Usage Rate was only 34.3%. In plain terms, what does that number mean for a team that decided to flag every player whose chart crossed the threshold for a mandatory medical evaluation?
3. Why does a selection-bias risk in publicly available injury data (less severe injuries being under-reported) tend to inflate, rather than deflate, a method's apparent sensitivity and specificity?

## Extensions

- Build a second chart for your Part 2 player using Minutes Played instead of field goal attempts as the workload proxy, and compare which one looks more informative for that specific player.
- If you have access to team-level box score totals, attempt a real, simplified Usage Rate calculation for your Part 2 player instead of a raw counting stat, and compare your own real sensitivity to the paper's own 77.8% real testing-season result for Usage Rate.
