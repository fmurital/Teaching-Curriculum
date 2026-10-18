# Module 6 Practice Questions (ungraded, multiple choice)

**Q1.** In plain language, what does a convolutional neural network do to an image as it moves from early layers to late layers?

A. It deletes most of the pixels to save memory
B. It progressively combines simple learned patterns (edges, curves) into more complex ones (a joint's location)
C. It converts the image into a spreadsheet with no further processing
D. It requires a human to hand-code every rule for what a joint looks like

**Q2.** MoveNet outputs how many real keypoints per detected person, and in what format?

A. 3 keypoints, each a single confidence score
B. 17 keypoints, each with an x-y pixel location and a confidence score
C. 100 keypoints, each a raw pixel color value
D. MoveNet does not output keypoints; it outputs a single bounding box

**Q3.** According to Google's real published benchmarks, how do MoveNet Lightning and Thunder differ?

A. They are identical in every respect
B. Lightning is tuned for speed; Thunder is tuned for accuracy, with real measured frame rates for each varying by device
C. Thunder only works on desktop computers; Lightning only works on phones
D. Lightning outputs fewer keypoints than Thunder

**Q4.** In Wei et al. (2025)'s real comparison of marker-based (Vicon) and markerless (Theia3D) motion capture in basketball players, which joint showed the strongest real agreement between systems?

A. The hip, during peak flexion
B. The ankle and knee, with real correlations of 0.94 or higher
C. The shoulder
D. No joints showed meaningful agreement

**Q5.** In Li et al. (2026)'s real comparison of a 25 Hz markerless system against a lab-grade Vicon system, what showed the weakest agreement between systems?

A. Joint position/displacement
B. Velocity and acceleration, derivatives of position that amplify small tracking errors
C. Camera calibration
D. Player identification

**Q6.** This module found that real free throw percentage across the 2017-18 season was essentially flat across quarters (roughly 77-80%). What does this module argue that flat result actually shows?

A. That fatigue never affects any basketball player under any circumstance
B. That box-score-level aggregates can miss the kind of joint-specific mechanical change that direct kinematic measurement is built to detect
C. That free throw shooting is a meaningless statistic
D. That the data must be wrong since a decline was expected

**Q7.** This module found a real 3-percentage-point drop in field goal percentage during the last three minutes of the fourth quarter compared to the rest of the game. What caution did the module attach to this real finding?

A. None; the finding proves fatigue-driven mechanical breakdown beyond doubt
B. The gap could partly reflect tighter late-game defense rather than the shooter's own fatigue, so it cannot be cleanly attributed to kinematics alone
C. The sample size was too large to be meaningful
D. Late-game shots do not count in the real data

**Q8.** Why does this module rely on real published research (Wei et al., Li et al.) and a real box-score proxy analysis instead of running a pose-estimation model on player video directly?

A. Pose-estimation models do not exist yet
B. The raw broadcast video and frame-level keypoint data needed are not available to redistribute or access in this course, so the module uses real data and real research it can honestly access instead of fabricating numbers
C. Running such a model is against the laws of physics
D. Box scores are always more accurate than pose estimation
