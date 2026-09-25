# Module 1 Practice Questions

These are for your own practice and are not submitted or graded. Solutions are discussed in class.

1. This course narrows the general field of sports analytics down to a specific approach. Which of the following best describes that approach, as laid out in Module 1?

A. It only covers injury prediction and ignores every other basketball question
B. It works through descriptive summaries, statistical modeling, and specialized methods using real NBA data and R, following one textbook's structure across the semester
C. It replaces statistical methods with scouting instinct and film study alone
D. It only covers spatial analysis of where players stand on the court

2. In Module 1's history of the field, whose book brought analytics thinking to a mainstream audience, and in what year?

A. Bill James, 1980
B. Michael Lewis's *Moneyball*, 2003
C. Dean Oliver's *Basketball on Paper*, 2004
D. Daryl Morey, 2006

3. Which of the following correctly describes the shape of the two datasets used in Module 1's worked example?

A. `Pbox` has 605 rows and 22 variables; `Tbox` has 30 rows and 23 variables
B. `Pbox` has 30 rows and 23 variables; `Tbox` has 605 rows and 22 variables
C. `Pbox` has 82 rows and 23 variables; `Tbox` has 30 rows and 22 variables
D. `Pbox` has 605 rows and 23 variables; `Tbox` has 30 rows and 22 variables

4. `Pbox` and `Tbox` both come from the same 2017-18 NBA season, yet `Pbox` has far more rows. What is the reason, according to Module 1?

A. `Pbox` includes preseason games that `Tbox` excludes
B. `Pbox` holds one row per player (605 players) while `Tbox` holds one row per team (30 teams), and a season has many more players than teams
C. `Pbox` counts every shot attempt as its own row
D. `Tbox` only includes playoff teams, while `Pbox` includes every player in the league

5. A classmate tells you "the team with the most points per game is definitely the best team in the league." Which of the following, drawn from Module 1, best explains what is missing from that claim?

A. Points per game cannot be computed from the `Tbox` dataset
B. Points per game is a purely descriptive number that does not account for pace, opponent strength, or defense
C. Points per game only applies to players, not teams
D. The claim is correct and nothing is missing from it

6. According to Module 1's discussion of hiring in sports analytics, which set of skills does it say employers consistently look for?

A. SQL, Python or R, statistics, data visualization, sport domain knowledge, and communication skills
B. SQL, Java, a machine learning certification, and public speaking coaching
C. Python, an MBA, negotiation, and accounting
D. R, marketing, front office experience, and public relations

7. Which of the following is one of the five throughlines this course returns to across the semester, as listed in Module 1?

A. Referee bias analysis
B. Fan engagement and ticket sales metrics
C. Injury detection and prediction
D. Television ratings analysis

8. Lab 1 computes each team's points per game with `Tbox$PPG <- round(Tbox$PTS / Tbox$GP, 1)`. Following that same pattern, which line of code correctly computes each team's average points allowed per game for a hypothetical `Obox` dataset with columns `PTS` and `GP`?

A. `Obox$PTS_allowed_per_game <- round(Obox$PTS / Obox$GP, 1)`
B. `Obox$PTS_allowed_per_game <- round(Obox$GP / Obox$PTS, 1)`
C. `Obox$PTS_allowed_per_game <- Obox$PTS - Obox$GP`
D. `Obox$PTS_allowed_per_game <- sum(Obox$PTS)`
