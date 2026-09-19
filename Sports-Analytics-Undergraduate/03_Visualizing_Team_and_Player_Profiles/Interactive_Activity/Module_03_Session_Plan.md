# Module 3 Session Plan: Visualizing Team and Player Profiles

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): Standardizing and radial profiles

- Quick recap of Module 2's net rating result and why single numbers
  stop working once you want to compare several stats at once (5 min).
- Lecture: the z-score formula, worked by hand on one or two values
  before touching R (15 min).
- Worked example, live in RStudio: build the five-player per-36 table,
  standardize it, and draw the `radialprofile()` chart for LeBron James,
  Stephen Curry, James Harden, Giannis Antetokounmpo, and Russell
  Westbrook (20 min).
- Cold-call discussion: pick one player's chart and describe their role
  using only the shape, then check it against the real z-score table
  (10 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Bar-line plots and honest reading

- Lecture: the Nylon Calculus radar-chart debate (Whitehead, 2017,
  citing Daryl Morey and Luke Bornn's criticism) as a case study in
  reading a chart type honestly rather than assuming it is either
  always right or always wrong (10 min).
- Worked example, live in RStudio: build the Houston Rockets bar-line
  chart (shooting splits plus minutes played) (15 min).
- Small groups (3-4 students): each group picks two Rockets players from
  the chart and writes one sentence describing whether that player's
  shooting efficiency matches what their playing time would predict
  (15 min).
- Groups report out (10 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Variability and team profiles

- Live demo: compute the weighted coefficient of variation for the
  Rockets' three shooting percentages, and let the room predict the
  ranking (most to least consistent) before revealing the real numbers
  (15 min).
- Walk through the team-level assists-versus-turnovers scatterplot
  together, connecting it back to net rating's much stronger 0.96
  correlation with wins from Module 2 (15 min).
- Tie back to the player-performance-analysis throughline: how a scout
  or an analytics department would use a standardized profile
  differently than a single stat (10 min).
- Assign Lab 3, Practice Questions, and the Module 3 quiz; preview
  Module 4 (shot charts and spatial data) (10 min).
