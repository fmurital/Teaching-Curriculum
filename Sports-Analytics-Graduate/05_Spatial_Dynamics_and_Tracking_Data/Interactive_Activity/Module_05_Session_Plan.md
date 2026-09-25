# Module 5 Session Plan: Understanding Players' Spatial Dynamics

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From stats to space, and real convex hulls

- I'll recap where Module 4 left off and introduce today's shift from
  treating players as numbers to treating them as real positions on a
  real court (5 min).
- I'll explain the real data-access gap up front: the textbook's own
  Chapter 5 examples need proprietary frame-by-frame tracking data we
  do not have, and what real substitute this module uses instead (10
  min).
- Live coding cue: we'll open RStudio together and build a real convex
  hull for one player's real shot locations (15 min).
- We'll look at the real Curry-versus-Green convex hull comparison
  together and discuss what a hull's shape and area tell you about a
  player's floor role (15 min).
- Quick discussion: real hull area versus real shot volume, using the
  real Kevin Durant example (5 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Real Voronoi tessellation

- Short lecture: what a Voronoi tessellation is and why I used each
  player's real median jump-shot location, not their raw shot mode, as
  the seed point (10 min).
- Live coding cue: we'll build the real tessellation together, live
  (15 min).
- We'll discuss the real resulting map: why Curry and Green get the
  largest real regions, and why the bench rotation's real regions
  cluster tightly (15 min).
- Small groups (3-4 students): each group picks two real players from
  the tessellation and writes one sentence describing how their real
  regions reflect their real roles (10 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Spatial distribution, gravity, and honest limits

- Live coding cue: we'll build the real kernel-density comparison
  (Curry vs. McGee) together (15 min).
- We'll discuss the real shape difference (McGee's single sharp peak
  versus Curry's rim-plus-arc pattern) and what a shooting percentage
  alone could never show you (10 min).
- I'll introduce the NBA's own real Gravity stat and the real 2025
  Scientific Reports tracking-based defensive-positioning finding, and
  we'll discuss what would change if we had that real tracking data
  ourselves (15 min).
- I'll close by connecting this module's spatial tools to the PhD
  track's real injury-risk work in Module 10, assign Lab 5, the
  practice questions, and the Module 5 quiz, and preview Module 6
  (athletic motion and pose estimation) (10 min).
