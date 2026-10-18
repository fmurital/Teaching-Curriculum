# Module 10 Notes: Injury Risk Signature Module (PhD Track)

## Where we left off, and where this module comes from

Module 9 closed this course's run through the textbook's own chapter structure: nine chapters, nine modules, ending with tree-ensemble scoring-probability models. This closing module is different on purpose. It does not map to a textbook chapter at all. It comes directly from my own published research program, and I am going to walk you through both papers in full, because by the end of today I want at least a few of you seriously considering a project in this exact space for your own thesis, dissertation, or publication.

I am going to give you the real methodology, the real numbers, and the real, honest limitations of two real papers, in the order they were actually written. The first applies statistical process control to Major League Baseball pitcher reinjury. The second, published this year, extends that same logic to the National Basketball Association. If you want a research trajectory that already has two published anchors behind it and real room left to extend, this is it.

## Part 1: The baseball paper, and why control charts at all

Brown, Muritala, and Haller (2026), published in *Research in Sports Medicine*, starts from a real, well-documented problem. Pitchers who undergo a rehabilitation stint for injury do not always come back fully recovered. Makhni et al. (2014), cited in the paper, found that 57% of pitchers who underwent Tommy John surgery between 1999 and 2011 needed a second injured-list stint for the same arm. Advanced methods exist for detecting this kind of decline, including convolutional neural networks trained on pitch-by-pitch video, but Piergiovanni and Ryoo (2019), also cited in the paper, needed an average of nearly 300 pitches per player just to train their own method, and still called that insufficient for detecting real deterioration. That is a real, practical barrier: most individual pitchers simply do not generate that much data fast enough for a data-hungry method to be useful in real time.

The paper's answer is to borrow directly from industrial statistical process control, a field built for exactly this problem: detecting a real change in a process from a short, ongoing stream of individual measurements, often with no large training set available at all. Two ideas from that field combine in this paper.

**Process capability (Cp).** In manufacturing, Cp asks whether a process reliably stays inside a specification limit. The paper adapts this into a one-sided version, Cpu, built from the league mean and standard deviation of a pitcher's performance metric (its Walks and Hits per Innings Pitched statistic, WHIP) from the prior season. This becomes the paper's Upper Specification Limit: USL = xbar + 3 * sigma-hat, computed once per season from every qualified pitcher in the prior year.

**CUSUM (cumulative summation).** Rather than judge each game in isolation, a CUSUM chart accumulates deviations from a target value over time, which makes it far more sensitive to a sustained, real decline than a single bad outing would be. The paper's one-sided upper CUSUM statistic is:

```
W_it = (USL - WHIP_it) / sigma_hat          # standardized distance from the limit
k = |USL - 3| / 2                           # slack value
C+_it = max(0, C+_i(t-1) + (W_it - 3 - k))  # cumulative statistic, resets at 0
```

A signal fires when C+_it exceeds a chosen decision interval, h. Smaller h catches more real signals, sooner, at the cost of more false alarms. Larger h is the opposite trade-off.

## Part 2: The real case studies, and the real honest trade-off

The paper's real data came from FanGraphs' public injury reports, 2021 through 2023, filtered down to pitchers who played for one team all year, had at most two injured-list stints, returned from their first stint before August, and had at least five game appearances after returning. That left a real analyzable sample of 558 pitchers across the three seasons (219, 192, and 147 respectively).

Two real pitchers anchor the paper's results, and I want you to sit with both of them, not just the one that worked.

**Adam Wainwright, 2023, h = 7.** Wainwright's CUSUM statistic stayed above zero for every appearance after his return from his first injured-list stint. It crossed the h = 7 decision interval five pitching appearances before he was placed on the injured list a second time. His standardized WHIP never returned to a capable level after his first return, and the chart caught that in real time.

**Adbert Alzolay, 2021, h = 12.** Here the method failed, and the paper says so directly. Alzolay's CUSUM statistic fluctuated but never crossed h = 12, even after the date of his actual second injured-list placement. The paper's own honest explanation matters: his second injury, a hamstring strain, was unrelated to his first, a finger blister. A chart built to detect a sustained performance decline from a *lingering* issue has no reason to catch a fresh, unrelated injury. This is the single most important caution in the whole module: a control-chart signal, or the absence of one, says something about sustained performance relative to a standard. It does not diagnose a cause, and it will never be a perfect injury detector for that reason alone.

Across all three seasons, the paper reports a real, textbook sensitivity-specificity trade-off as h increases (its Table 1): at h = 7, sensitivity ran from 79.45% to 84.85% across the three seasons, with specificity from 26.71% to 28.95%. At h = 12, sensitivity dropped to 48.68% to 71.23%, while specificity rose to 33.97% to 41.23%. The paper's own recommendation, balancing the low real cost of an unnecessary medical check against the high real cost of a missed reinjury, is to operate somewhere between h = 7 and h = 12. At h = 10 specifically, the chart's real mean lead time (its Table 2) was 8.02, 7.20, and 6.14 games across the three seasons, meaning the method signalled, on average, six to eight real games before the pitcher's actual second injured-list placement.

## Part 3: The basketball paper, published this year, with your own professor as a co-author

Tention, Muritala, Frankel, and Brown (2026), published in *Basketball Studies*, asks the obvious next question: does this same logic work in a completely different sport, with completely different performance metrics, and no WHIP equivalent? The answer, carefully qualified, is yes, with real, lower, and honestly reported accuracy.

The real data came from the hoopR package, covering the 2021-2022 through 2025-2026 NBA regular seasons, with the first four seasons used as training data and the full 2025-2026 season held out as a genuine, unseen test set. After filtering to injuries that cost a player at least two games and that resulted in a return within four games of first eligibility, the real qualifying sample was 58, 31, 29, 38, and 53 athletes per season, 209 athlete-seasons in total: 157 Lower Extremity injuries, 22 Core, 25 Upper Extremity, and 5 Other. The mean number of games missed in a qualifying stint was 5.89 (95% CI: 5.33, 6.49).

This paper makes two real methodological advances over the baseball paper, and you should understand both, because extending a published method honestly, rather than just re-running it, is exactly the kind of contribution a strong thesis chapter makes.

**An individualized baseline, not a league-wide one.** Rather than comparing every player to the same league standard the way the WHIP paper did, this paper builds each player's own specification limit as a credibility-weighted blend of that player's own pre-injury mean and the league grand mean:

```
mu-hat_0i = (n_i * xbar_i + k_m * xbar) / (n_i + k_m)
LSL_i = mu-hat_0i - 2 * sigma-hat_0
```

Here k_m is a single, pooled value estimated once across every player for a given metric, reflecting how much real signal exists between players relative to the real noise within a single player's own game-to-game numbers. A player with many real pre-injury games gets judged mostly against their own history. A player with little data falls back toward the league standard. This directly answers one of the baseball paper's own stated limitations, that WHIP was judged against the whole league rather than each pitcher's own individualized level.

**An EWMA-CUSUM hybrid, not a pure CUSUM.** The paper's plotting statistic blends the interpretability of an Exponentially Weighted Moving Average with the downward-shift logic of CUSUM:

```
c_ij = min(0, lambda * (W_ij - 2) + (1 - lambda) * c_i(j-1))
```

Values of lambda between 0.45 and 1.0 and decision intervals h between 0.05 and 0.50 were searched on the training seasons, selecting the pair that best classified real subsequent-injury outcomes for each metric, then freezing that pair and testing it once, honestly, on the real held-out 2025-2026 season.

**The real results.** Four performance metrics were evaluated: Player Impact Estimate (PIE), Usage Rate, Box Plus-Minus (BPM), and Net Rating. On the real held-out test season, Usage Rate gave the best overall balance: sensitivity 77.8% (95% CI: 58.0%, 97.5%), specificity 34.3% (95% CI: 18.3%, 50.2%), accuracy 49.1%. PIE had the next-best sensitivity at 72.2%, but a lower specificity of 25.7%. Across all four metrics, the real mean lead time before a subsequent injury, on the held-out season, ran from 5.75 games (Net Rating) to 6.33 games (BPM), with Usage Rate at 5.79 games, comparable in magnitude to the baseball paper's own six-to-eight-game lead time, in a genuinely different sport with genuinely different data.

Notice what is honestly, deliberately not claimed here. A specificity in the 20s and 30s percent means this method, run exactly as published, would flag a real, meaningful share of healthy players as at-risk. A sensitivity around 60-78% means a real, meaningful share of actual subsequent injuries would not be caught at all. This is a real, usable, published early-warning signal, not a diagnosis, and the paper says so.

## Part 4: Watching this method actually run on new, real data

I built the paper's general logic myself, live, on a real case that happened after both papers were already written: Victor Wembanyama's 2025-26 season. I chose this case honestly, before knowing what the chart would show, which is itself the right habit for you to build. Here is exactly what I found.

Wembanyama was shut down in February 2025 for a real, serious blood clot in his shoulder and was not medically cleared to return to full activity until July 2025. He opened the healthy 2025-26 season on October 22, 2025. Rather than reproduce Usage Rate exactly, which needs full team-level box score totals, I used a simpler, real, single-number workload proxy any of you could pull yourselves: his own game-by-game field goal attempts, standardized against his own real first-eleven-game baseline this season, run through a simplified version of the paper's EWMA statistic with lambda = 0.45, the paper's own preferred smoothing weight.

On November 14, 2025, in his twelfth game, Wembanyama suffered a real calf strain. He was reported out for multiple weeks on November 18 and did not play again until December 13, 2025, a real 29-day gap.

The real result: my chart did not flag him before that game. His standardized workload statistic sat comfortably inside a +/-1.0 threshold for all twelve pre-injury games. This is not a failure of the exercise. It is exactly the honest, expected outcome for an acute, traumatic, in-game muscle strain, which has no reason to be preceded by a gradual workload decline the way a lingering overuse injury would be, the same real distinction the baseball paper's own Wainwright-versus-Alzolay contrast makes. What the chart did pick up, honestly, was a real dip to around -1.3 standard deviations in the games immediately *after* his return, consistent with a deliberate, cautious workload ramp-up by his team, not a missed warning.

## Part 5: Where you could take this

Both papers end with real, stated limitations, and a limitations section in a published paper is the single best place to go looking for your own thesis topic, because the authors have already told you, in writing, what is still open. From the baseball paper: injuries were not differentiated by type, and contextual factors like opponent quality or ballpark effects were not included. From the basketball paper: player performance metrics only capture part of player health, a new-contract player's role change can swing Usage Rate independent of health, and reliance on publicly available injury data brings a real, documented selection-bias risk that less-severe injuries are under-reported, which can inflate a method's apparent accuracy.

A few real, concrete directions worth your own consideration: extending the basketball paper's individualized-baseline approach back into the original baseball WHIP method, which still used a league-wide standard. Differentiating chart performance by real injury type the way this module's case studies already suggest matters. Combining a workload-based signal like Usage Rate with real biomechanical or video-based indicators, bridging back to the CNN-based work both papers cite as a harder-to-scale alternative. Or, if you want a direct continuation of today's own live demonstration, building a properly individualized, full Usage Rate version of today's illustration and testing it honestly against a real, different injury case than the one I happened to pick.
