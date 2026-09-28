# Module 7 Session Plan: Ball Trajectories and Object Detection

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From tracking the player to tracking the ball

- I'll recap where Module 6 left off (pose estimation applied to a
  player's body) and introduce today's shift: the same family of
  computer vision technique, object detection, applied to the ball
  itself, and why the ball is a genuinely harder real target.
- Short lecture: YOLO and single-pass object detection, in plain
  language, before any numbers.
- I'll walk through the real Liang et al. (2025) BGS-YOLO precision,
  recall, and mAP numbers, and we'll discuss as a class why recall
  moved less than precision even after purpose-building the model.
- Small groups (3-4 students): each group picks one real cause of
  ball-detection difficulty (motion blur, occlusion, small apparent
  size) and writes one sentence on how a research team might try to
  address it.

**Break (10 minutes).**

## Segment 2 (50 minutes): The real physics of a trajectory

- Short lecture: I'll derive the real minimum-speed trajectory result
  in plain language, building up from the general projectile-motion
  case to Brancazio's (1981) basketball-specific application.
- Live coding cue: we'll open RStudio together and compute the real
  six-distance trajectory table together.
- We'll look at the real theta_min-versus-distance chart together and
  discuss why the real angle converges toward 45 degrees at longer
  range.
- Live coding cue: we'll compute the real gap between the theoretical
  minimum-speed angle and the real published shooting-angle figures
  together, and discuss what that real gap is telling us about rim
  size and entry angle.

**Break (10 minutes).**

## Segment 3 (50 minutes): Connecting the physics to real outcomes

- Live coding cue: we'll build the real FG%-by-distance curve from
  `PbP.BDB` together.
- Small groups: each group compares the real FG% curve to the real
  trajectory table and identifies which real distance range shows the
  clearest physical explanation for its real shooting percentage.
- I'll introduce the PhD/advanced-project connection: how consistent,
  season-long real launch-angle tracking could function as a
  biomechanical injury-risk indicator, previewing Module 10.
- I'll close by assigning Lab 7, the practice questions, and the
  Module 7 quiz, and preview Module 8 (performance maps and court
  segmentation).
