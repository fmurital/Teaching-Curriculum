# Module 2 Practice Questions (Ungraded)

These are for your own practice and do not count toward your grade. Try
each one before checking your work in RStudio.

1. Pace measures how many possessions a team uses per 48 minutes. Why
   does computing it correctly require both a team's own box score and
   its opponents' box score?

A. It does not; pace can be computed from a team's own box score alone
B. A possession only ends when the ball changes hands (a make, a defensive rebound, a turnover, or the end of a free throw trip), and that handoff is only fully defined by combining what the team did with what its opponents did against it
C. Opponent box scores are only needed to compute defensive rating, not pace
D. Pace is only meaningful for the five fastest teams in the league

2. A team scores 108 points per game. In this module's real data, why
   isn't that enough by itself to say the team has a good offense?

A. It is enough; points per game is the standard measure of offense
B. Points per game can only be computed for individual players, not teams
C. You would need to know the team's pace, or better, its points per 100 possessions (offensive rating), to know whether 108 points reflects real efficiency or just extra possessions from playing fast
D. 108 points per game is below the league average, so the team's offense must be bad

3. In Dean Oliver's original Four Factors weighting from *Basketball on
   Paper* (2004), what is the correct order of factors from highest
   weight to lowest?

A. Shooting (40%), turnovers (25%), rebounding (20%), free throws (15%)
B. Turnovers (40%), shooting (25%), free throws (20%), rebounding (15%)
C. Rebounding (40%), shooting (25%), turnovers (20%), free throws (15%)
D. Free throws (40%), rebounding (25%), shooting (20%), turnovers (15%)

4. Effective field goal percentage (eFG%) counts a made three-pointer as
   worth more than a made two-pointer. Why does that matter for comparing
   two teams with very different three-point attempt rates?

A. It doesn't matter; raw field goal percentage already accounts for shot value
B. A three-pointer is worth 50% more than a two-pointer, so raw field goal percentage understates the value created by a team that shoots a high volume of threes at a similar make rate to its twos; eFG% corrects for that
C. Three-pointers are excluded from eFG% entirely
D. eFG% only applies to free throw shooting, not field goals

5. In the 2017-18 data used in this module, effective field goal
   percentage correlates with wins at about 0.77, while net rating
   correlates with wins at about 0.96. What best explains why net rating
   captures more of what makes a team win?

A. Net rating is simply eFG% multiplied by a constant, so the two numbers must be related
B. Net rating incorporates both scoring efficiency and defensive performance across every possession, so it captures far more of what determines a game's outcome than one offensive shooting stat can alone
C. eFG% is measured on a different scale, which makes its correlation appear artificially low
D. Net rating and eFG% measure the same underlying skill, so the difference is a data error

6. A team has a high offensive rebound rate but also a high turnover
   rate. What does that combination suggest about how the two factors
   interact?

A. The two factors are unrelated and cannot both be evaluated for the same team
B. A high offensive rebound rate creates extra scoring chances, while a high turnover rate destroys them, so the two can partly cancel out, netting a less dominant offense than either number alone would suggest
C. High offensive rebounding always outweighs turnovers, so this team's offense must be elite
D. High turnover rate cancels out only defensive rebound rate, not offensive rebound rate

7. In the real 2017-18 data, the Boston Celtics had the best (lowest)
   defensive rating in the league at 101.54, with 55 wins. Based on this
   module, what does that result best illustrate?

A. The Celtics were a top-5 team in wins that season because of their defense alone
B. A team can have the league's best defensive rating and still not be a top-5 team in wins, which shows offense also drives win totals, not defense alone
C. Defensive rating has no relationship to a team's win total
D. Defensive rating cannot be computed without also computing offensive rating

8. In the 2017-18 data, free throw rate correlated with wins at about
   0.40, behind eFG% (0.77) but ahead of offensive rebound rate (0.25)
   and turnover rate (-0.14). Which explanation best fits why getting to
   the free throw line often would help a team win, beyond the direct
   free points themselves?

A. Free throws count for more points than field goals, so free throw rate matters only because of the extra points
B. Attacking the basket often (rather than settling for jump shots) tends to draw fouls on opposing defenders and disrupt a defense's rhythm, in addition to the direct value of the free points
C. Free throw rate is really just another way of measuring a team's pace
D. Free throw rate matters only for teams with a low offensive rebound rate
