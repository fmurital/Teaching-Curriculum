# Module 4 Quiz (Microsoft Forms, 8 questions, multiple choice)

Paste each question into forms.office.com as its own Choice question; mark the correct option using Forms' own settings.

**Q1.** This module splits Golden State's real 2017-18 season into two
segments using which rule?
A. Home games versus away games
B. Games 1-41 versus games 42-82, chronologically
C. Wins versus losses
D. Games decided by more than ten points versus everything else

**Q2.** Golden State's real record and net rating moved from the first
real season segment to the second real season segment in which
direction?
A. Record and net rating both improved
B. Record stayed exactly the same; net rating improved
C. Record slipped slightly (30-11 to 28-13) and net rating fell (plus
   9.86 to plus 5.47), driven mainly by a real rise in defensive rating
D. Both offense and defense improved equally

**Q3.** An adjusted offensive or defensive rating (`AORtg`/`ADRtg`), as
implemented in this module, differs from a plain offensive or
defensive rating because it:
A. Only counts fourth-quarter possessions
B. Corrects each team's rating for the strength of the specific
   opponents it played
C. Ignores defense entirely
D. Is only defined for a full 82-game season

**Q4.** In this module's real data, Golden State's `AORtg` and `ADRtg`
compute to:
A. Values close to the full-season NBA average
B. Exactly 0.00, in every segment
C. Negative numbers only
D. Undefined (`NA`)

**Q5.** The real reason Golden State's adjusted rating collapses the
way it does is:
A. A coding bug in `TOPboxes()`
B. GSW actually had a perfectly average season
C. Almost every GSW opponent in this dataset appears only in its own
   games against GSW, so that opponent's own rating (used to adjust
   GSW's number) collapses to being identical to GSW's own performance
   against them, canceling the adjustment out
D. The `AdjRtg()` formula does not work for teams with winning records

**Q6.** Why does a team like Portland, which also only appears in this
dataset playing GSW, still receive a real, non-zero adjusted rating?
A. Portland is adjusted against GSW's defensive rating, which is itself
   built from roughly twenty-five to thirty different real opponents,
   a genuine outside benchmark
B. Portland's games are excluded from the adjustment entirely
C. Portland's adjusted rating is also exactly 0.00
D. The formula treats home and away teams differently

**Q7.** The real CART tree fit on the other teams' segment-1 adjusted
ratings, predicting real wins in this sample, produced a first split
on:
A. `ADRtg1 < 0`
B. Team name
C. `AORtg1 < -0.015`
D. Number of games played

**Q8.** This module's own textbook chapter and Kubatko et al. (2007)
are both cited for:
A. Coding syntax for `rpart`
B. The Offensive/Defensive Rating concept that adjusted ratings build
   on top of, plus the season-segments methodology this module
   reproduces
C. NBA scheduling rules
D. The Gini coefficient
