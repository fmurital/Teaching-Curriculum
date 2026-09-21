# Module 02 Notes: Beyond Individual Skills — Lineups and Combinations

**Graduate — Sports Analytics** | Textbook: Zuccolotto, Manisera, & Sandri (2026), Chapter 2.

## The problem this module solves

A player's box score line looks the same no matter who else is on the court. In practice, the same player can play a completely different role depending on the other four players sharing the floor with them. This module builds the tools to see that directly: a **lineup split** isolates the portion of a play-by-play dataset that happened while one specific five-player combination was on the court together, so we can compute the same box scores, assist networks, and shot charts we already know how to build, for that combination instead of for a whole team or player.

## Finding lineups worth analyzing

With a 10-player pool, there are 252 different ways to choose 5 of them (`nCm(10, 5) = 252`). We have no way to know in advance which of those 252 combinations actually shared the floor long enough to say anything meaningful. `BasketballAnalyzeR`'s `lineups()` function (or `parlineups()` for larger rosters, using parallel computing) solves this by computing the minutes played by every possible k-player combination drawn from a list of players, so we can filter down to the ones worth a closer look.

## The real example: 2021-22 Golden State Warriors

Using the play-by-play data for the Golden State Warriors' 2021-22 regular season and a 10-player pool (Andrew Wiggins, Draymond Green, Gary Payton II, Jonathan Kuminga, Jordan Poole, Kevon Looney, Klay Thompson, Otto Porter Jr., Moses Moody, Stephen Curry), filtering to lineups that played at least 48 minutes together produced exactly eight real combinations, reproduced in the textbook's Table 2.1. One of them, Wiggins/Green/Poole/Looney/Curry, dominates the list at 346.1 minutes together, dwarfing every other combination. That is the starting group; everything else on the list is a variation the coach tried for specific matchups, foul trouble, or rest.

## What stayed the same, what changed, across eight networks

Building a separate assist-shot network for each of the eight lineups (the same `assistnet()` function from Module 01, just run on eight different filtered subsets of play-by-play) showed a consistent pattern: Stephen Curry sits at the center of the thickest, reddest assist connection in nearly every lineup. What changes is who is on the other end of that connection, Klay Thompson in one lineup, Draymond Green in another, Otto Porter Jr. in a third. The star's role as a hub barely moves. Everyone else's role shifts depending on who else is on the floor.

The shot-distance density plots told a similar story with the numbers: Kevon Looney's finishing rate at the rim stayed unusually high across every lineup he appeared in (as high as 79% made in one combination, 71% in the primary starting group), while three-point production in the starting lineup came overwhelmingly from Stephen Curry (150 of that lineup's three-point points).

## Pace, Ratings, and the Four Factors, one level down

The formulas do not change from what a full-team or full-player analysis already uses: Effective Field Goal Percentage, Turnover Ratio, Rebound Percentage, and Free Throw Rate (the Four Factors, Kubatko et al., 2007) and Pace/Offensive Rating/Defensive Rating are computed exactly the same way at any level. What changes here is the unit: instead of a whole team or a whole player, each formula is now applied to one five-man lineup at a time, using `fourfactors()` on the lineup-level box scores built with `TOPboxes()`.

The real result for the eight Warriors lineups: Wiggins + Green + Poole + Porter Jr. + Curry had both the fastest Pace (about 2.24 possessions per minute) and the best Offensive Rating (about 124) of the eight. Wiggins + Green + Poole + Looney + Thompson had the worst Defensive Rating (opponents scored about 130 per 100 possessions against that group). Neither number alone settles which lineup a coach should trust in a close game; that tension is exactly what a real lineup decision has to weigh.

## Connecting to this course's own track

Every lineup decision is also a workload decision. The 346-minute starting lineup absorbed far more cumulative wear than any bench combination this season. West et al. (2026) is directly relevant here: it addresses the statistical process control needed to trust the workload data teams collect in the first place, before that data can be used to flag an athlete at elevated risk.
