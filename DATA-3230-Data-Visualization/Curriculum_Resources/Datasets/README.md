# Datasets

Both running datasets for DATA 3230 are real, public records, not simulated or invented data. This file records where each one came from, exactly how it was produced from the original source, and what license governs it.

## Housing: `ames_housing.csv`

**Source.** The Ames, Iowa residential sale records collected and described in De Cock, D. (2011). "Ames, Iowa: Alternative to the Boston Housing Data as an End of Semester Regression Project." *Journal of Statistics Education*, 19(3). The Ames City Assessor's Office provided the original records directly to the author; they cover 2,930 arm's-length and non-arm's-length residential sales from 2006 through 2010.

**How this file was built.** The raw 2,930-row, 82-column dataset (`ames_raw`) is distributed as part of the `AmesHousing` R package (Max Kuhn, CRAN), whose public source repository mirrors CRAN's own copy. I downloaded the raw data object from that repository's `data/ames_raw.rda` file and loaded it in R. From there I selected 18 columns relevant to this course (sale price, neighborhood, living area, lot area, bedrooms, bathrooms, basement size, overall quality and condition, year built, year remodeled, house style, building type, garage capacity, and sale month/year), kept only sales flagged `Normal` in the original `Sale Condition` field (dropping foreclosures, family sales, and incomplete new construction, which is standard practice with this dataset since it keeps sale price comparable across rows), and removed the small number of rows with missing basement, living-area, or garage data. This is my own column selection and cleaning pass, not the AmesHousing package's own `make_ames()` processing function.

**Resulting file.** 2,413 rows, 18 columns. Sale prices range from \$35,000 to \$755,000, across 28 Ames neighborhoods, sales from 2006 through 2010. Columns: `pid`, `sale_price`, `neighborhood`, `gr_liv_area` (above-grade living area, sq ft), `lot_area` (sq ft), `bedroom_abvgr`, `full_bath`, `half_bath`, `total_bsmt_sf`, `overall_qual` (1-10), `overall_cond` (1-10), `year_built`, `year_remod_add`, `house_style`, `bldg_type`, `garage_cars`, `mo_sold`, `yr_sold`.

**License.** The De Cock (2011) article's text may be freely shared but not republished without permission; this does not cover the underlying city-assessor sale records, which the author has made freely available for teaching and has stated he is willing to share with interested parties. The `AmesHousing` R package that mirrors this raw data is released under an open-source license (GPL-3) on CRAN. This dataset is used here strictly for teaching, as De Cock's original article intended, with full citation above.

## Student performance: `student_performance_math.csv`

**Source.** Cortez, P. (2008). *Student Performance* [Dataset]. UCI Machine Learning Repository. https://doi.org/10.24432/C5TG7T. The data covers secondary-school student achievement at two Portuguese schools, collected from school reports and questionnaires during the 2005-2006 school year, as described in Cortez, P., & Silva, A. (2008). "Using Data Mining to Predict Secondary School Student Performance." In A. Brito & J. Teixeira (Eds.), *Proceedings of 5th FUBUTEC Conference*, pp. 5-12. EUROSIS.

**How this file was built.** UCI distributes this as two files, one for the Mathematics course and one for Portuguese. This course uses the Mathematics file (`student-mat.csv`), downloaded unmodified, column for column, from its original form as published by UCI. No rows or columns were removed or altered.

**Resulting file.** 395 rows (students), 33 columns, no missing values. Columns cover demographics (`school`, `sex`, `age`, `address`, `famsize`, `Pstatus`), parental background (`Medu`, `Fedu`, `Mjob`, `Fjob`), school-related factors (`studytime`, `failures`, `schoolsup`, `famsup`, `paid`, `activities`, `higher`, `internet`), social and health factors (`famrel`, `freetime`, `goout`, `Dalc`, `Walc`, `health`, `absences`), and three grading periods (`G1`, `G2`, final grade `G3`), each on a 0-20 scale.

**License.** Creative Commons Attribution 4.0 International (CC BY 4.0), as stated on the dataset's UCI Machine Learning Repository page. This permits sharing and adaptation for any purpose with appropriate credit, which is given above.

## Quick-access datasets

`palmerpenguins`, `ggplot2::mpg`, and `ggplot2::diamonds` are used directly from their R packages for short in-class examples and need no separate file here; each carries its own documentation and license within its package.
