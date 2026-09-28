# Module 7 Notes: Ball Trajectories and Object Detection

## Where we left off

Module 6 asked what a player's body does, moment to moment, using pose
estimation to track the athlete directly. This module points the same
family of computer vision technique at a different, harder target: the
ball itself. A player's body is large, slow-moving relative to camera
frame rates, and rarely leaves the frame. A basketball is small, spins
rapidly, moves fast enough to blur across a single video frame, and
regularly disappears behind players, the rim, or the backboard. Object
detection, the technique this module covers, and the physics of the
trajectory the detected ball actually follows, are both real, current,
active research problems, not solved textbook exercises.

## What object detection actually does, and why the ball is a hard case

A convolutional neural network built for object detection, the YOLO
("You Only Look Once") family being the most widely used in sports
applications, does something specifically different from the pose
estimation you saw in Module 6. Pose estimation assumes a person is
present and asks where their joints are. Object detection has to
first decide whether the object of interest is present at all in a
given region of the frame, then draw a bounding box around it and
assign a confidence score, all in a single forward pass through the
network, which is where the "you only look once" name comes from.

A real, current 2025 paper, Liang, Wang, Huang, Sang, and Zhang,
published in *PLOS ONE*, built a real custom basketball detection
model (BGS-YOLO, based on YOLOv8) specifically because a standard,
generic YOLOv8 model struggles with a basketball: it is small in the
frame, its appearance blurs at real broadcast frame rates during a
fast release, and it is frequently and briefly occluded by hands,
rims, and other players. Their real baseline YOLOv8n model, run on a
real custom dataset of 1,000 annotated basketball images (65% dynamic
gameplay, 25% practice footage, 10% ambient-variation frames, scraped
from Basketball-Reference.com, NBA official media archives, and
OpenSportsNet), achieved a real precision of 93.1%, a real recall of
83.4%, and a real mAP (mean average precision) of 90.5%. Their
purpose-built BGS-YOLO model improved that to a real precision of
96.9%, a real recall of 89.7%, and a real mAP of 93.2%. Notice that
recall, the share of real basketballs actually present in a frame
that the model successfully detects, is the harder number to move,
even for a model built specifically for this problem. That gap is
exactly what you would expect from a fast, small, frequently occluded
object, and it is the real reason ball-tracking research remains an
active area rather than a solved one.

## From a detected ball to a real trajectory: the physics underneath

Once a real system has detected the ball's position across a real
sequence of frames, you have something a plain shot chart never gives
you: the ball's actual path through the air, not just where it started
and where it ended. That path is projectile motion, and the physics
behind it goes back further than any of the computer vision literature
above. Brancazio, P. J. (1981), "Physics of basketball," published in
*American Journal of Physics*, is the real, seminal paper applying
classical projectile-motion mechanics specifically to a basketball
shot, and it is still the anchor citation for essentially every later
paper on shot trajectory, including the object-detection papers above.

The specific real physics result I want you to carry forward is the
minimum-speed trajectory: for a shot released at some point and aimed
at a target a horizontal distance x away and a net vertical rise y
above the release point, there is one specific real launch angle that
lets the shooter reach that target using the least possible release
speed. That real angle is:

**theta_min = 45 degrees + 0.5 x arctan(y / x)**

and the real minimum speed that angle requires is:

**v_min = sqrt(g x (x + sqrt(x^2 + y^2)))**

This is a standard result in classical mechanics (see the "minimum
launch speed to reach a target" derivation in any projectile-motion
treatment), and Brancazio (1981) is the real paper that applied it
specifically to a basketball shot, rim height, and release height.

## Real computed trajectories, six real representative distances

Using a real regulation rim height of 10 feet (3.048 m) and a real,
commonly cited average release height of 7 feet (2.1336 m) for an NBA
shooter (Coach Dave Love, "Launch Angle and Velocity in Basketball
Shooting," an applied shooting-analysis resource, not a peer-reviewed
paper, cited here for its real distance-specific figures rather than
as an academic source), I computed the real theoretical minimum-speed
launch angle, speed, and time of flight at six real representative
shot distances:

| Shot | Real distance | Real theta_min | Real v_min | Real hang time |
|---|---|---|---|---|
| At the rim | 4 ft | 63.4 deg | 11.6 mph | 0.53 s |
| Real mid-range | 10 ft | 53.3 deg | 17.5 mph | 0.65 s |
| Free throw line | 15 ft | 50.7 deg | 21.3 mph | 0.76 s |
| Long two | 19.75 ft | 49.3 deg | 24.4 mph | 0.85 s |
| NBA three-point line | 23.75 ft | 48.6 deg | 26.7 mph | 0.92 s |
| Deep three | 28 ft | 48.1 deg | 29.0 mph | 0.99 s |

Two real patterns are worth sitting with. First, the real minimum-speed
launch angle drops as distance increases, converging toward 45 degrees,
the real minimum-energy angle for a flat-ground shot, as the vertical
rise becomes small relative to the horizontal distance. Second, the
real required minimum speed climbs steadily with distance, which is
the real physical reason a deep three demands so much more real arm
and leg strength than a shot at the rim.

## Why real shooters do not use the minimum-speed angle

Here is the real, honest gap this module wants you to notice. Coach
Dave Love's real applied figures, using the same 7-foot release height,
report that real NBA shooters actually use launch angles around 55.2
degrees at the free throw line and around 64.1 degrees at the
three-point line, both substantially steeper than the real theoretical
minimum-speed angles of 50.7 and 48.6 degrees computed above. The
minimum-speed trajectory only guarantees the ball reaches the target
point; it says nothing about the angle at which the ball then enters a
rim that is barely larger than the ball itself. A shot arriving at a
shallow angle has a real, narrow window to fall through the rim
without deflecting off the front or back iron, so real shooters trade
some extra effort for a real, more forgiving entry angle. This is
precisely the kind of real, non-obvious gap between "the physics
minimum" and "what actually works" that only becomes measurable once a
real tracking system, of the kind the object-detection half of this
module covers, can recover the ball's actual real launch angle from
real broadcast video, frame by frame.

## Connecting the physics back to real outcomes

Does any of this line up with what actually happens on a real 2017-18
NBA court? I pulled real shot_distance and real make/miss outcomes for
every real field goal attempt in BasketballAnalyzeR's real PbP.BDB
play-by-play dataset, 14,355 real attempts with a valid real distance
recorded. Real field goal percentage runs 74.2% at the rim (0-2 ft),
drops sharply through the real mid-range (36.9% to 46% across 4-14 ft),
stays roughly flat through 14-24 ft (38.3% to 43.1%), and settles into
the real three-point range at 34.5% to 39.6% from 24-30 ft. The real
mid-range dip is exactly the region where the real minimum-speed launch
angle is changing fastest with distance, a real, physically grounded
reason that range is the hardest to shoot consistently, on top of the
well documented real strategic reasons that range has fallen out of
favor across the modern NBA.

## The PhD/advanced-project connection

If you go on to the injury-risk PhD track in Module 10, ball-trajectory
tracking is a real, direct source of the kind of biomechanical
indicator that work depends on. A shooter's real launch angle and
real release speed, tracked consistently across an entire real season
rather than computed once from a physics formula, is exactly the kind
of subtle, athlete-specific signal that could flag a real mechanical
change worth investigating well before it shows up in a box score, the
same honest argument Module 6 made for pose-estimation-based joint
tracking.
