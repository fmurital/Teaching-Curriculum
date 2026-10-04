# Module 8 Session Plan: Basketball Performance Maps Based on Court Segmentation

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From real sectors to a real shot chart

- I'll recap Module 7's ball-trajectory work and introduce today's
  shift: from tracking a single shot's path to mapping scoring
  probability across the whole court.
- Live coding cue: we'll normalize real shot coordinates onto one
  half-court together and build the real sector-based performance map
  from Part 1 of the notes.
- I'll highlight the real mid-range-versus-three expected-points gap
  (0.876 versus 1.143) and connect it directly to modern shot
  selection strategy.
- Live coding cue: we'll build the real Golden State shot chart
  together with `drawNBAcourt()`.

**Break (10 minutes).**

## Segment 2 (50 minutes): Letting a real model find the boundaries itself

- Short lecture: introduce CART in plain language before any code,
  using a simple non-basketball example (a tree that decides loan
  approval by income and credit score) to set up the idea of
  recursive splitting.
- Live coding cue: we'll build the real Cartesian CART model together
  and read the printed real tree as a class.
- Discussion: what real basketball situation does the close-range,
  sharp-angle split actually describe, and why would a coach care?
- Live coding cue: we'll render the real CART performance-map heat
  image together and compare it visually to the Part 1 sector map.

**Break (10 minutes).**

## Segment 3 (50 minutes): Cartesian versus polar, and wrap-up

- Live coding cue: we'll build the real polar CART model together and
  compare its real training accuracy directly to the Cartesian
  model's.
- Small groups (3-4 students): each group argues for either the
  Cartesian or the polar model as the one they would hand to a real
  coaching staff, then one group from each side presents its case to
  the rest of the class.
- PhD/advanced-project callout: I'll connect this module's CART
  structure to Module 10's injury-risk thread, where the same kind of
  model partitions real athletes into real risk groups instead of
  real court locations into real scoring-probability groups.
- I'll close by assigning Lab 8, the practice questions, and the
  Module 8 quiz, and preview Module 9 (machine learning scoring
  probability models).
