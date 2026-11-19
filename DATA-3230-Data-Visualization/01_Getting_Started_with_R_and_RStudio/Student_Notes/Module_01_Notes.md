# Module 1 Notes: Getting Started with R and RStudio

## What this course actually teaches

Data visualization is not just making charts look nice. It is the last, and often most important, step in a research process: get real data, understand what it actually says, and communicate that honestly to an audience who will act on it. This course works through that process using the R programming language and two real, running datasets, a home-sale dataset from Ames, Iowa and a student performance dataset from two Portuguese secondary schools, so that every chart you build this semester is grounded in real numbers, not invented ones.

## A short, real history of the tools

R was created by Ross Ihaka and Robert Gentleman at the University of Auckland as a teaching tool for an introductory statistics course. It was inspired by an earlier language called S, and most S code still runs in R unchanged. The two professors first released R publicly in August 1993, posting a binary file to a data archive site called StatLib and announcing it on a mailing list. It has been free and open source ever since.

RStudio, the IDE (integrated development environment) you write and run R code in, is a separate piece of software built on top of R. The company RStudio was founded in 2009, and in 2022 it renamed itself Posit to reflect that its tools support more than just R. The name on your Start menu may say either RStudio or Posit depending on when you installed it; they are the same software.

The package this course leans on most for actually drawing charts, `ggplot2`, was created by Hadley Wickham and first released in 2007. It implements a specific idea called the Grammar of Graphics, laid out in Leland Wilkinson's book of the same name (2nd ed., 2005): instead of picking a chart type off a menu, you build a graphic in layers, by mapping data to aesthetics (position, color, size) and adding geometric objects (bars, points, lines) on top. Module 3 covers this in depth; for now, just know where the name comes from.

## This course's two running datasets

Rather than a different, disconnected dataset every module, this course returns all semester to two real datasets you will get to know well:

- **Housing.** 2,413 real home sales in Ames, Iowa, from 2006 through 2010, originally collected by the Ames City Assessor's Office and published for teaching by De Cock (2011). Each row is one normal-condition home sale, with its price, neighborhood, square footage, bedrooms, and other features.
- **Student performance.** 395 real students at two Portuguese secondary schools, from Cortez and Silva's 2008 study, with their study habits, family background, and three grading-period grades.

Full source and license details for both are recorded in `Curriculum_Resources/Datasets/README.md`. Neither dataset is simulated, and nothing in this course's worked examples is invented; every number you see came directly from one of these two files or from a small, well-known R package dataset used for quick in-class examples.

## Why R, for a course aimed at your next job

R is not the only tool used for data visualization in industry (Module 10 touches on where a dashboarding tool like Power BI fits alongside what you learn here), but it remains one of the most common tools for data analysts and scientists who need to go from raw data to a specific, defensible chart, especially where reproducibility matters: anyone can rerun your R script and get your exact chart back, which is not always true of a chart built by pointing and clicking.

## Today's worked example

In class we loaded both datasets and took a first, honest look at them with `dim()` and `names()`. We then asked one purely descriptive question of the housing data: among Ames neighborhoods with at least 20 sales in this data, which had the highest average sale price? The top five were NoRidge (\$326,114), NridgHt (\$302,479), StoneBr (\$276,269), Veenker (\$255,866), and Timber (\$241,773). We then built a simple horizontal bar chart of average sale price across all 23 qualifying neighborhoods, sorted from lowest to highest. Nothing in that chart was invented; it came directly from the real 2,413-row dataset every student now has on their own machine.
