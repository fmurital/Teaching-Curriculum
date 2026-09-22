# Module 4 Session Plan: Season Segments and Final Rankings

**Format:** one 3-hour graduate session, three segments, two 10-minute
breaks. Timing lives only here and in slide speaker notes, never printed
on a slide face.

## Segment 1 (50 minutes): A season in two acts

- I'll recap Module 3's situational splits and introduce today's shift:
  splitting an entire season into two acts instead of splitting a
  single game by time and score (5 min).
- I'll walk through the methodological note on our data: why the
  textbook's own Italian league file and `AdjRtg()` function are not
  available to us, and how this module reproduces the chapter's real
  methodology on GSW's real, complete 2017-18 regular season instead
  (10 min).
- Live in RStudio, I'll build the real per-game box scores together
  with you, one game at a time across the season, and we'll confirm
  the real game count and date range together (20 min).
- Discussion: I want a few of you to explain, in your own words, why
  this dataset's hub-and-spoke shape (every other team appearing only
  against GSW) is different from a normal league season, before we get
  to why that matters later in the session (15 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Adjusted ratings, and a real surprise

- We'll implement `AdjRtg()` from the textbook's own formulas together,
  live, and run it on the full real season (20 min).
- I'll show you Golden State's real two-segment split, the 30-11 first
  half against the 28-13 second half, and we'll discuss what the real
  ORtg/DRtg numbers say about which side of their game moved (15 min).
- We'll run `AdjRtg()` on GSW specifically and get the real result:
  exactly 0.00 for both `AORtg` and `ADRtg`, in every segment. I'll ask
  the room to propose explanations before I walk through the real
  mechanism, using the matrix computation on screen to show exactly
  where the cancellation happens (15 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): CART, the alluvial figure, and the literature

- We'll fit the real CART tree on the other teams' segment-1 adjusted
  ratings together, live, and discuss the real first split (`AORtg1 <
  -0.015`) and why this small, noisy sample calls for a genuinely
  exploratory reading of the tree rather than a confident predictive
  claim (20 min).
- Small groups: I'll ask each group to trace one team's path through
  the real alluvial diagram (`module4_alluvial.png`) and report back
  what that team's segment-1 ratings suggest about its real wins in
  this sample (15 min).
- PhD-track callout: for anyone considering the larger independent
  project track, I'll connect today's hub-and-spoke adjusted-rating
  degeneracy forward to the ACWR methodological-critique thread we
  return to in Module 10 (5 min).
- I'll assign Lab 4, the practice questions, and the Module 4 quiz, and
  preview Module 5 (spatial dynamics and tracking data) (10 min).
