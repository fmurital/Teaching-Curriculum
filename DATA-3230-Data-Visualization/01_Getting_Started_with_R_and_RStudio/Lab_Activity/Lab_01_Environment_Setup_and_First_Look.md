# Lab 1 (Guided): Environment Setup and a First Look at Real Housing Data

## Learning Objectives

By the end of this lab, you will be able to install and open R and RStudio, load a real dataset from a CSV file, describe its structure, and compute a simple, honest summary statistic from it.

## Dataset

This lab uses `ames_housing.csv`, a real, cleaned extract of 2,413 Ames, Iowa home sales (2006-2010), and introduces `student_performance_math.csv`, a real dataset of 395 Portuguese secondary-school students, which later modules use. Full source and license details are in `Curriculum_Resources/Datasets/README.md`; both files live in that same folder.

## Instructions

1. Install R and RStudio (or Posit Cloud, if you prefer not to install anything locally) if you have not already; both are free. Confirm RStudio opens and shows a console.
2. Install the two packages this lab needs: `install.packages(c("ggplot2", "readr"))`.
3. Create a new RStudio project in a folder of your choosing, and copy `ames_housing.csv` and `student_performance_math.csv` from `Curriculum_Resources/Datasets/` into that same folder.
4. Load both packages: `library(ggplot2)` and `library(readr)`.
5. Load the housing data: `housing <- read_csv("ames_housing.csv")`.
6. Check its shape with `dim(housing)`. Confirm you get 2,413 rows and 18 columns.
7. Run `names(housing)` and read through the column names. `sale_price`, `neighborhood`, and `gr_liv_area` (above-grade living area, in square feet) will come back often in later modules.
8. Find every neighborhood with at least 20 sales in the data (`table(housing$neighborhood)`), then compute the average `sale_price` for each of those neighborhoods using `aggregate()`.
9. Sort that result from highest to lowest average price and print the top 5 neighborhoods.
10. Build a horizontal bar chart of average sale price for every qualifying neighborhood, sorted from lowest to highest, using `ggplot2`. The full working script is provided in `Coding_Exercise/module1_first_look.R` if you want to check your work, but try steps 8 through 10 yourself first.

## Guidance

If `install.packages()` fails, check that your R version is current and that you have an internet connection RStudio can reach. If a specific dependency fails to install, install that package by name first, then retry.

`neighborhood` is stored as a character column until you convert it. To control the order neighborhoods appear in a `ggplot2` bar chart, convert the summarized table's neighborhood column to a factor first, ordered by its average price, exactly as shown in the coding exercise script.

## Reflection Questions

1. This dataset only includes sales flagged "Normal" in the original records, dropping foreclosures and family sales. Why might a course (or a real analyst) choose to exclude those before computing something like "average sale price"?
2. Average sale price is a purely descriptive statistic. What is one question about a neighborhood's housing market that average sale price cannot answer by itself, and why?
3. Which neighborhood had the highest average sale price in your chart? Does that match what you would have guessed, or does it surprise you?

## Extensions

If you finish early, load `student_performance_math.csv` with `read_csv()`, check its shape with `dim()` (you should get 395 rows and 33 columns), and compute the average final grade (`G3`) for students who reported more than 2 hours of weekly study time (`studytime`) versus those who reported 2 or fewer. We will return to this exact comparison in a later module.
