# Module 6 Session Plan: Athletic Motion Kinematics Analysis

**Format:** one 3-hour class session, three segments, two 10-minute breaks.

## Segment 1 (50 minutes): From position to motion, and how a CNN sees a body

- I'll recap where Module 5 left off (spatial dynamics, convex hulls, Voronoi tessellation) and introduce today's shift: from where a player is to what their body is doing while they get there.
- I'll be upfront about the real data-access gap this module works within: no proprietary broadcast video, no fabricated joint angles. I want you to see exactly how I handle a real limitation honestly, because you'll hit the same kind of gap in your own independent projects.
- Short lecture, in plain language first: what a convolutional neural network actually does to an image, building from edges to shapes to joints, no equations yet.
- Video: 3Blue1Brown's "But what is a neural network?" (or the first several minutes of it), to ground the CNN concept visually before we touch MoveNet specifically.
- I'll introduce MoveNet's real 17-keypoint output and its two real variants (Lightning and Thunder), with Google's own real published speed benchmarks.
- Quick pair discussion: why does inference speed (frames per second) matter specifically for capturing something as fast as a crossover dribble.

**Break (10 minutes).**

## Segment 2 (50 minutes): What the real published research says pose estimation can and cannot do yet

- Short lecture: markerless motion capture validation studies, what they test and why validation against a marker-based system matters before you trust any markerless number.
- I'll walk through Wei et al. (2025) in detail: real methodology (12 real professional players, three real jump types, Vicon versus Theia3D), and the real finding that ankle and knee agree strongly while hip does not.
- I'll walk through Li et al. (2026) in detail: real methodology (six-camera markerless at 25 Hz versus 10-camera Vicon), and the real finding that position agrees well while velocity and acceleration do not.
- Small groups (3-4 students): each group is assigned one of the two real studies and prepares a two-minute explanation, for the rest of the class, of what a practitioner should and should not trust from that specific real system.
- Video: real game footage, Kyrie Irving crossover slow-motion compilation, watched alongside a discussion of which of the real joints and quantities just covered you would need reliable pose data for if you wanted to actually quantify what makes that move effective.

**Break (10 minutes).**

## Segment 3 (50 minutes): The real, honest substitute analysis, and connecting it to injury risk

- Live coding cue: we'll open RStudio together and build the real free-throw-by-quarter analysis from `PbP.BDB`, live.
- We'll look at the real, flat result together and discuss why a flat aggregate result is itself informative rather than a failed analysis.
- Live coding cue: we'll build the real turnover-rate-by-quarter and late-game fatigue-window analyses together.
- Video: real game footage, Stephen Curry shooting form slow-motion breakdown, watched alongside a discussion of which parts of his release you could measure reliably with current markerless technology and which parts (per today's two real studies) you could not yet trust.
- Small groups: each group picks one real finding from today (the flat free throw trend, the flat turnover trend, or the real 3-point late-game FG% gap) and drafts one sentence a team's sports science staff could actually act on, or one sentence explaining why they should not act on it yet.
- I'll close by connecting today directly to the PhD injury-detection track (Module 10) and Faruk's own published work on data quality and workload monitoring, assign Lab 6, the practice questions, and the Module 6 quiz, and preview Module 7 (tracking and analyzing ball trajectories with object detection).
