# Module 3 Session Plan: Clutch Performance and Situational Splits

**Format:** one 3-hour graduate session, three segments, two 10-minute
breaks. Timing lives only here and in slide speaker notes, never printed
on a slide face.

## Segment 1 (50 minutes): Defining clutch and rebuilding the pipeline

- I'll recap Module 2's lineup work and introduce today's situational
  split: time and score instead of personnel (5 min).
- I'll walk through the exact clutch definition (under five minutes
  remaining, score within five points) and why a precise, reproducible
  rule matters more here than a broadcast-style "felt tense" judgment
  (10 min).
- Live in RStudio, I'll build the `TOPboxes()` input pipeline together
  with you, including the methodological note on why we are using real
  2018 playoff data instead of the textbook's own private file (20 min).
- Discussion: I want a few of you to explain, in your own words, why the
  `oreb`/`dreb` indicators have to be built by hand rather than pulled
  directly from the raw data (15 min).

**Break (10 minutes).**

## Segment 2 (50 minutes): Team splits, real surprises

- We'll compute Golden State's and Boston's real Clutch-versus-General
  Four Factors together, live (20 min).
- I'll walk through why Golden State's real defensive rating got
  noticeably worse in the clutch that postseason, and Boston's real
  offensive rating jumped, and push on what that does and does not tell
  us about either team (15 min).
- Small groups: I'll ask each group to compute the Gini coefficient
  shift for one of the two teams and come back with one sentence
  describing what it means for who takes over late in a close game
  (15 min).

**Break (10 minutes).**

## Segment 3 (50 minutes): Player indices and the literature

- We'll build the full player-level clutch index table together for
  Golden State, live, and discuss what `Diff` and `Prc` mean for two or
  three real players (20 min).
- I'll introduce Goldman & Rao's (2012) asymmetric-pressure argument and
  ask the room to sort our real player table into "more effort" and
  "less efficient" columns based on their own `Diff` and `Prc` values
  (15 min).
- PhD-track callout: for anyone considering the larger independent
  project track, I'll connect this module's situational-split logic
  forward to the workload-monitoring methods we will use in Module 10
  (5 min).
- I'll assign Lab 3, the practice questions, and the Module 3 quiz, and
  preview Module 4 (season segments and final rankings) (10 min).
