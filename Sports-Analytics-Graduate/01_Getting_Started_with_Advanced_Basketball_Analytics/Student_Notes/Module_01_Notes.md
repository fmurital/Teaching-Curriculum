# Module 01 Notes: Getting Started with Advanced Basketball Analytics

**Graduate — Sports Analytics** | Textbook: Zuccolotto, Manisera, & Sandri (2026), *Advanced Basketball Data Science: With Applications in R*, CRC Press.

## Where this course picks up

This course assumes the tools from the undergraduate course: R, RStudio, and the `BasketballAnalyzeR` package (Zuccolotto & Manisera, 2020). If any of that setup is rusty, revisit the undergraduate Module 01 lab before this session.

What is new here is the level of the questions we ask. The undergraduate course used box-score data (Pace, Four Factors, player efficiency) to describe what happened in a game or a season. This course adds three things the textbook builds toward across its nine chapters: statistical and machine-learning models fit to that data (CART, random forests, logistic regression), play-by-play and lineup-level analysis instead of only season totals, and — starting with player tracking and pose estimation in later chapters — motion data that box scores never capture at all.

## Two workflow habits from Chapter 1

**`pacman`.** The book loads its packages once with `pacman::p_load(...)` instead of separate `install.packages()` and `library()` calls for each one. It installs a package only if it is missing, then loads it. This matters more in this course because we will accumulate a longer list of dependencies (`network`, `sna`, `GGally`, `ggnetwork`, and later, packages for CART and tracking data) than the undergraduate course needed.

**`conflicted`.** `dplyr` and base R (and other tidyverse packages) both define functions with the same names, most commonly `filter()` and `arrange()`. Loading both silently lets one mask the other, and a masked function can produce output that looks fine but is not what you intended. The book's fix is `conflicted::conflict_prefer("filter", "dplyr")` and the same for `arrange`, made explicit rather than left to whichever package loaded last.

## Worked example 1: a real dplyr pipeline on `Pbox`

We built a five-verb pipeline against the `Pbox` data frame bundled in `BasketballAnalyzeR` (2017-18 NBA season): filter to players with at least 500 minutes, mutate a per-game points column, select the columns we care about, arrange descending, and slice the top of the list.

The real result (min. 500 minutes, 2017-18 season): James Harden (Houston Rockets) led at 30.4 PPG, followed by Anthony Davis (28.1), LeBron James (27.3), a tie between Giannis Antetokounmpo and Damian Lillard (26.9), and a tie between Kevin Durant and Stephen Curry (26.4), down to Russell Westbrook at 25.4.

The point of this exercise is not the leaderboard. It is that a single points-per-game number collapses everything about how a player scores — volume, efficiency, who set it up — into one figure. That is exactly the gap the rest of the course exists to close.

## Worked example 2: a real assist network for the Golden State Warriors

Using `PbPmanipulation()` to prepare play-by-play data and `assistnet()` to build the network, we computed the 2017-18 Golden State Warriors' assist network. The result's `nodeStats` table showed Draymond Green with 509 total assists, ahead of Kevin Durant (366) and Stephen Curry (309), with Klay Thompson and Andre Iguodala also represented in the network.

The more interesting number was not total assists but the share of a player's own made shots that came off someone else's pass: 83% of Klay Thompson's made shots were assisted, versus only 54% of Kevin Durant's. A box score cannot show that difference. An assist network can, because it tracks who passes to whom, not just how many points each player scored.

## The three papers this course's own track is built around

This course is not restricted to the textbook. Where a real journal article sharpens or extends what the book covers — especially on this course's own signature track, injury-risk detection — it will be named on the slide and cited in these notes, not left as an unsourced aside:

- Muritala, Brown, & Haller (2026). *Research in Sports Medicine* — MLB pitcher reinjury.
- West et al. (2026). *Journal of Strength and Conditioning Research* — statistical process control for sport-science data quality.
- Kanwal et al. (2025) — a critique of the Acute:Chronic Workload Ratio (ACWR).

By the end of the course, the goal for every student — and the required deliverable for anyone pursuing the larger PhD-level project — is to find a real indicator of injury risk in data and connect it to a specific, cited model, using this track as the starting point rather than the ceiling.
