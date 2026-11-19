# Module 1 Practice Questions

These are for your own practice and are not submitted or graded. Solutions are discussed in class.

1. This course is built around two real, running datasets rather than one specialized topic. Which of the following best describes why, as laid out in Module 1?

A. Because specialized topics are too difficult for a 3000-level course
B. So that worked examples stay grounded in real, relatable numbers (home sales, student grades) that any student can reason about
C. Because R cannot handle more than one dataset at a time
D. Because the housing and student datasets are the only two datasets available in R

2. In Module 1's history of the tools, who created R, and where?

A. Hadley Wickham, at Stanford University
B. Ross Ihaka and Robert Gentleman, at the University of Auckland
C. Leland Wilkinson, at the University of Illinois at Chicago
D. JJ Allaire, at RStudio

3. Which of the following correctly describes the shape of the two datasets introduced in Module 1?

A. `housing` has 2,413 rows and 18 columns; `students` has 395 rows and 33 columns
B. `housing` has 395 rows and 33 columns; `students` has 2,413 rows and 18 columns
C. `housing` has 2,413 rows and 33 columns; `students` has 395 rows and 18 columns
D. `housing` has 2,930 rows and 18 columns; `students` has 395 rows and 33 columns

4. The housing dataset only includes sales flagged "Normal" in the original records. According to Module 1's lab, why does this matter?

A. It does not matter; the flag was ignored
B. Excluding foreclosures, family sales, and incomplete new construction keeps "sale price" meaningfully comparable across rows
C. "Normal" sales are the only sales legally allowed to be studied
D. It increases the dataset from 2,413 to 2,930 rows

5. A classmate tells you "NoRidge is definitely the best neighborhood in Ames." Which of the following, drawn from Module 1, best explains what is missing from that claim?

A. Average sale price cannot be computed from this dataset
B. Average sale price is a purely descriptive number that says nothing about school quality, commute times, or what "best" means to a given buyer
C. The claim is correct and nothing is missing from it
D. NoRidge is not actually in the dataset

6. According to Module 1, what idea does `ggplot2`, the package this course uses most, implement, and who originally proposed that idea?

A. The Grammar of Graphics, proposed by Leland Wilkinson
B. Tidy data, proposed by Hadley Wickham
C. The Bootstrap, proposed by Bradley Efron
D. Exploratory data analysis, proposed by John Tukey

7. Lab 1 computes average sale price by neighborhood with `aggregate(sale_price ~ neighborhood, data = housing, FUN = mean)`. Following that same pattern, which line of code would correctly compute each neighborhood's average `gr_liv_area` instead?

A. `aggregate(gr_liv_area ~ neighborhood, data = housing, FUN = mean)`
B. `aggregate(neighborhood ~ gr_liv_area, data = housing, FUN = mean)`
C. `aggregate(sale_price ~ gr_liv_area, data = housing, FUN = sum)`
D. `mean(housing$gr_liv_area, housing$neighborhood)`

8. What year was RStudio, the company, founded, and what did it later rename itself to, according to Module 1?

A. Founded 1993, renamed R Foundation
B. Founded 2007, renamed ggplot2 Inc.
C. Founded 2009, renamed Posit (in 2022)
D. Founded 2005, renamed Wilkinson Graphics
