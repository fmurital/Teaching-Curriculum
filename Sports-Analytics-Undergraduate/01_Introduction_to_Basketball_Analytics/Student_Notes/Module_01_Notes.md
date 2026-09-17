# Module 1 Notes: Introduction to Basketball Analytics

## What sports analytics actually is

Sports analytics is the use of data and statistical methods to describe what happened in a game, evaluate players and teams, and support decisions that coaches, front offices, and broadcasters actually make. It is not a single technique. It spans simple descriptive summaries (how many points a team scores per game), statistical modeling (which factors predict a win), and specialized methods like spatial analysis of player positioning or process control applied to injury risk. This course works through that range using real NBA data and the R programming language, following Zuccolotto and Manisera's *Basketball Data Science: With Applications in R* (2020).

## A short, real history

Sports analytics did not start with basketball, and it did not start recently. Operations researchers began applying statistical methods to sports after World War II. Bill James, writing outside of any team's front office, published his *Baseball Abstracts* between 1977 and 1988 and coined the term "sabermetrics" in 1980. Michael Lewis's book *Moneyball* (2003) brought this way of thinking to a wide audience by describing how the Oakland Athletics used unorthodox statistics to find undervalued players.

Basketball has its own parallel history. Dean Oliver published *Basketball on Paper* in 2004, introducing the Four Factors framework this course covers in Module 2. Player tracking arrived in the NBA through SportVU cameras, first adopted by a handful of teams around 2010, and became leaguewide in every arena by 2013. That tracking data is what eventually made shot charts, player movement analysis, and load management discussions possible at the scale we see today.

## Why this matters for getting hired

Employers hiring for sports analytics roles consistently look for a specific combination of skills: SQL for working with databases, Python or R for analysis and modeling, applied statistics, data visualization, and enough knowledge of the sport itself to know which numbers matter. Just as important are the communication skills to explain findings to a coach or general manager who is not going to read a regression table. This course is built to give you real practice with all of these, not just the technical half.

## The analytics workflow this course follows

Every module in this course, including this one, follows the same basic sequence: get real data, describe it honestly before modeling it, model it carefully once description is not enough, and communicate the result in a way a non-technical decision-maker could actually use. Module 1 is entirely about the first step of that loop: getting your R environment working and taking an honest first look at real data before you try to explain anything about it.

## The five throughlines

Rather than treating each module as a disconnected topic, this course returns repeatedly to five questions that a real analytics department actually asks: how do you detect and predict injury risk, how good is a player once you account for role and context, where players stand on the court and how that changes what a play can become, how pay relates to production, and what a single game's events actually tell you happened. You will see each of these referenced again as the course goes on.

## Today's worked example

In class we installed the `BasketballAnalyzeR` package and loaded two of its real datasets: `Pbox`, which holds one row per player (605 players, 22 variables) from the 2017-18 NBA season, and `Tbox`, which holds one row per team (30 teams, 23 variables) for that same season. We computed each team's points per game and looked at the top five scoring teams, then built a simple chart of every team's win total for the season. Nothing in that chart was invented. It came directly from the data the package ships, the same data used throughout Zuccolotto and Manisera's textbook.
