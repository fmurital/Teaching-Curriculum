# Module 6 Session Plan: Event Density and Shooting Under Pressure

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): Where events pile up in time

- I'll recap where Module 5 left off (correlation and assist networks)
  and introduce today's shift: putting time back into the picture,
  instead of season-long totals (5 min).
- I'll introduce event density in plain language, using a simple
  non-basketball example, before we touch any code (10 min).
- Live coding cue: we'll open RStudio together and load the real
  `PbP.BDB` play-by-play data, then run `densityplot()` on `playlength`
  across every real field goal attempt (15 min).
- We'll look at the real density curve together as a class: where it
  peaks, and the smaller second bump late in the shot clock (10 min).
- Quick pair discussion: what real basketball behavior produces that
  second bump? (10 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Turning "late in the clock" into a real number

- Short lecture: I'll define the three shot-clock buckets (early, mid,
  late) and explain why higher `playlength` means more pressure (10
  min).
- Live coding cue: we'll build the real shot-clock bucket table
  together and compute real field goal percentage in each bucket (15
  min).
- We'll look at the real 7.2 percentage point drop and discuss what it
  does and does not prove on its own (10 min).
- We'll then build the real three-point-only version together and
  discuss why 3P% is worst at both extremes, not just late (15 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Clutch time and who takes the real pressure shots

- I'll introduce the NBA's own real clutch-time definition (last 5
  minutes, margin within 5) and why `periodTime >= 420` captures it in
  this dataset (10 min).
- Live coding cue: we'll build the real clutch-time split together and
  compare clutch versus non-clutch real field goal percentage (15
  min).
- Small groups (3-4 students): each group looks at the real
  player-level clutch attempts table, picks one player, and debates
  whether a lower clutch shooting percentage than season average makes
  that player a worse clutch performer (15 min).
- I'll close by connecting this to real player performance analysis
  and game analysis, assign Lab 6, the practice questions, and the
  Module 6 quiz, and preview Module 7 (finding groups: clustering
  players and teams) (10 min).
