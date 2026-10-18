# Assignment 2: Shot Charts, Correlation, and Shooting Under Pressure

**Sports Analytics (Undergraduate)** -- covers Modules 4-6 (shot charts, correlation and player networks, event density and shooting under pressure).

**Due:** -- set by instructor before posting --

**Total: 100 points (4 problems, 25 points each)**

This assignment uses the real 2017-18 play-by-play sample built into `BasketballAnalyzeR` (`PbP.BDB`), which covers that season's playoffs. Unless a problem tells you otherwise, use Russell Westbrook (Oklahoma City Thunder) -- a player we have not yet worked with together in Modules 4-6. Submit your script and any plots along with your written answers.

## Problem 1 -- A real shot chart (25 points)

a. (10 pts) Filter `PbP.BDB` to Russell Westbrook's shot attempts (made and missed) and report the total number of field goal attempts you find in this data sample, along with his overall field goal percentage.
b. (10 pts) Group his attempts into four distance zones of your choosing (for example: at the rim, short/mid-range, long two, and three-point range) and report the number of attempts and field goal percentage in each zone.
c. (5 pts) Based on your zone breakdown, describe in one or two sentences where Westbrook took most of his volume, and where he shot most efficiently. Are those the same zone?

## Problem 2 -- Correlation across the league (25 points)

Using the real `Tbox` team season data:

a. (10 pts) Compute each team's three-point attempt rate (three-point attempts as a percentage of all field goal attempts) and the correlation between that rate and each team's win total.
b. (10 pts) Compute the correlation between a team's total assists and its total turnovers for the season.
c. (5 pts) Name the team with the highest three-point attempt rate and the team with the lowest, along with each team's win total. Does a high three-point rate guarantee a good record? Use your correlation from part (a) to support your answer.

## Problem 3 -- Shooting under pressure (25 points)

a. (12 pts) Using `PbP.BDB`, define a "clutch" shot attempt for Russell Westbrook as one taken in the 4th quarter or overtime with the score within 5 points at the time of the shot. Report his field goal attempts and field goal percentage in clutch situations versus all other (non-clutch) situations.
b. (8 pts) Based on these two numbers, would you say Westbrook's shooting efficiency changed in clutch moments in this sample? Name a limitation of drawing a strong conclusion from this specific comparison (hint: think about one of the two numbers you just computed).
c. (5 pts) Propose one additional piece of context (not already in this dataset) that would make your clutch-shooting comparison more convincing to a coach.

## Problem 4 -- Reading a small sample correctly (25 points)

A student on your team says: "Westbrook shot 66.7% in the clutch and only 46.6% otherwise in this dataset, so he is clearly a better shooter under pressure, and the team should run every close-game possession through him."

a. (15 pts) Is this a sound conclusion to draw from the numbers in Problem 3? Explain what is wrong (or right) about the student's reasoning, specifically addressing the sample sizes involved in each of the two percentages being compared.
b. (10 pts) Suggest one specific additional analysis (using data of the kind we have worked with this semester) that would make this argument more rigorous before taking it to a coaching staff.
