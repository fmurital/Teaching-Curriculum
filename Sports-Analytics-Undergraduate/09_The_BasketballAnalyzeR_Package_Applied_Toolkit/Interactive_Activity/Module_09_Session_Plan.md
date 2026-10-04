# Module 9 Session Plan: The BasketballAnalyzeR Package, Applied as One Toolkit

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): Where does a box score actually come from?

- I'll recap Modules 1 through 8 as four real pieces of a toolkit
  (visual profiles, shot charts, correlation and networks, clustering,
  regression), then tell the class today is about seeing the whole
  toolkit at once, starting with where the numbers themselves come
  from.
- Live coding cue: we'll open RStudio together and rebuild the
  Rockets' box score directly from real play-by-play with
  `TOPboxes()`.
- I'll walk through why the rebuilt real point total (352) is so much
  smaller than the real full-season total (9,213), using what the
  class already knows from Module 5 about how `PbP.BDB` is scoped
  around Golden State's schedule.
- Live coding cue: we'll rebuild Golden State's box score the same
  way and compare its real `GP` value to the Rockets', confirming the
  real game-coverage difference directly.

**Break (10 minutes).**

## Segment 2 (50 minutes): How evenly is scoring spread, and the whole league at once

- Short lecture: introduce the real Gini coefficient in plain terms
  (the same real tool used for income inequality) before showing any
  code.
- Live coding cue: we'll compute the real Gini index for the Rockets'
  top 8 scorers together.
- Cold call: before I reveal the Warriors' real number, I'll ask the
  class to predict whether it will be higher or lower than the
  Rockets', and why, then we'll run it live and discuss the real
  surprise together.
- Live coding cue: we'll build the real league-wide bubble chart
  together and each find our own favorite team on it.
- Pair discussion: using only the bubble chart, each pair writes a
  one-sentence real statistical identity for a team I assign them.

**Break (10 minutes).**

## Segment 3 (50 minutes): Is this shot good for this specific player, and wrap-up

- Live coding cue: we'll build the real expected-points-by-distance
  chart for James Harden and Chris Paul together and discuss where
  their real curves separate from the team average.
- Small groups (3-4 students): each group picks a different real pair
  of Golden State players and builds the same chart, then reports one
  real finding back to the class.
- I'll close by having the class put all four tools from today
  together into one real scouting-profile paragraph for a team of
  their choosing (the Lab 9 extension), assign Lab 9, the practice
  questions, and the Module 9 quiz, and preview Module 10 (quality
  monitoring and injury risk).
