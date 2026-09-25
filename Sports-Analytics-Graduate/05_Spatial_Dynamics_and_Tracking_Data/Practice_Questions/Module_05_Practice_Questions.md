# Module 5 Practice Questions (ungraded, multiple choice)

**Q1.** Why can't this module reproduce the textbook's own Chapter 5
speed/acceleration figures directly from `PbP.BDB`?
A. `PbP.BDB` has no real spatial data of any kind
B. Those figures need frame-by-frame optical player-tracking data, and `PbP.BDB` only has event-level shot locations, not a continuous position feed
C. Speed and acceleration cannot be computed from any basketball dataset
D. The textbook's Chapter 5 does not actually use tracking data

**Q2.** A convex hull applied to a player's real shot locations shows:
A. The player's shooting percentage
B. The smallest polygon containing every one of the player's real shot locations, i.e. their real shot territory
C. The player's real assist total
D. A prediction of the player's next shot location

**Q3.** In this module's real data, Stephen Curry's shot-territory convex hull (2,538 sq ft) is larger than Draymond Green's (2,264 sq ft). What does that real difference most directly reflect?
A. Curry took more total real shots than Green
B. Curry's real shots reach a wider real area of the floor, including deep and both corners, while Green's cluster closer to the rim and short midrange
C. Green never shoots from outside the paint
D. Hull area is unrelated to where a player actually shoots from

**Q4.** Kevin Durant led the real 2017-18 Warriors in shot attempts (1,221) but his real convex hull area (2,018 sq ft) was smaller than Klay Thompson's (2,599 sq ft, 1,178 attempts). What does this real comparison show?
A. Shot volume and real floor coverage are the same thing
B. Real floor coverage (hull area) and real shot volume are separate questions; a high-volume scorer is not automatically the player covering the most real territory
C. Durant's data must be an error, since he took the most shots
D. Klay Thompson took more real shots than Durant

**Q5.** This module's real Voronoi tessellation uses each player's median jump-shot location as the seed point, excluding shots within 10 feet of the basket. Why exclude those close shots?
A. Close shots are not real data
B. Nearly every player's single most common real shot location is at the rim, so including it would collapse every player's seed to the same point
C. The Voronoi method cannot process shots near the basket
D. Rim shots are excluded from `PbP.BDB` entirely

**Q6.** In the real Voronoi map, which real players get the two largest regions?
A. The two players whose real median jump-shot locations sit closest to the basket
B. Draymond Green and Stephen Curry, whose real median jump-shot locations sit furthest from the tightly clustered bench rotation
C. Every player gets an equally sized region regardless of shot location
D. Only players who never attempt three-pointers

**Q7.** The real kernel-density comparison shows JaVale McGee with a single sharp density peak near the basket and Stephen Curry with a rim peak plus a second ridge along the three-point arc. What does this comparison demonstrate that a single shooting percentage cannot?
A. Nothing; shooting percentage already captures shot location
B. The full real shape of where a player's shots concentrate, not just how often they go in
C. McGee and Curry have identical real shot profiles
D. Kernel density cannot be computed for basketball shot data

**Q8.** The NBA's own real Gravity stat is computed from 3D pose detection tracking 29 points on a player's body, 60 times per second. Why can't this module compute that exact real statistic?
A. Gravity is not a real NBA statistic
B. That statistic requires proprietary frame-by-frame optical tracking data that is not available in any dataset this course has access to
C. `PbP.BDB` already includes the real Gravity stat directly
D. Gravity can be computed from shooting percentage alone
