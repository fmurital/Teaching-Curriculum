# Module 05 Quiz (Auto-Graded, D2L, multiple choice)

8 questions, 1 point each.

**Q1.** A convex hull applied to a player's real shot locations shows:
A. The player's shooting percentage
B. The smallest polygon containing every one of the player's real shot locations
C. The player's real assist total
D. A prediction of the player's next shot

**Q2.** What real, freely available data does this module use in place of the textbook's proprietary frame-by-frame tracking data?
A. Simulated random coordinates
B. Real shot-location coordinates (`original_x`, `original_y`) from `BasketballAnalyzeR::PbP.BDB`
C. Data purchased directly from the NBA
D. Player height and weight only

**Q3.** In this module's real data, whose shot-territory convex hull is larger: Stephen Curry's or Draymond Green's?
A. Draymond Green's
B. Stephen Curry's
C. They are exactly equal
D. Neither player has a computable hull

**Q4.** Kevin Durant led the real 2017-18 Warriors in shot attempts but had a smaller real convex hull area than Klay Thompson. What does this show?
A. Real shot volume and real floor coverage are the same measurement
B. Real floor coverage and real shot volume are separate questions
C. Durant's data is incorrect
D. Thompson took more shots than Durant

**Q5.** Why does this module's real Voronoi tessellation exclude shots within 10 feet of the basket before computing each player's seed point?
A. To remove players who play center
B. Because nearly every player's single most common shot is at the rim, which would collapse every seed to the same point
C. Rim shots are not part of `PbP.BDB`
D. To make the map easier to color

**Q6.** In the real Voronoi map, Draymond Green and Stephen Curry get the two largest regions because:
A. They took the fewest real shots
B. Their real median jump-shot locations sit furthest from the tightly clustered bench rotation
C. They are team captains
D. The map assigns region size randomly

**Q7.** The real kernel-density comparison between Stephen Curry and JaVale McGee shows:
A. Identical real shot distributions for both players
B. McGee with a single sharp peak near the basket; Curry with a rim peak plus a second ridge along the three-point arc
C. Both players shoot exclusively from the three-point line
D. Density cannot be estimated from real shot data

**Q8.** Why can't this module compute the NBA's official real Gravity stat directly?
A. Gravity is not a real statistic the NBA tracks
B. It requires proprietary frame-by-frame optical tracking data (29 body points, 60 times per second) not available to this course
C. `PbP.BDB` already contains the Gravity stat
D. Gravity only applies to defensive players
