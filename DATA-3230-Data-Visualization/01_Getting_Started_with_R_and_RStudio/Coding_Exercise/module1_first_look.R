# Module 1: Getting Started with R and RStudio
# Data Visualization (DATA 3230)
#
# This script sets up the R environment used all semester and takes a
# first look at the two real datasets this course runs on all term: a
# real Ames, Iowa housing-sale dataset and a real secondary-school
# student performance dataset. Full source and license details for both
# are in Curriculum_Resources/Datasets/README.md.

# install.packages(c("ggplot2", "readr"))  # run once, then comment out
library(ggplot2)
library(readr)

# The two running datasets for this course. No data is simulated: both
# come from the real, cited public sources documented in
# Curriculum_Resources/Datasets/README.md.
housing <- read_csv("ames_housing.csv", show_col_types = FALSE)
students <- read_csv("student_performance_math.csv", show_col_types = FALSE)

dim(housing)    # 2413 home sales, 18 variables
dim(students)   # 395 students, 33 variables
names(housing)

# A first, purely descriptive question: which Ames neighborhoods had the
# highest average sale price, among neighborhoods with at least 20 sales
# in this data?
nbhd_counts <- table(housing$neighborhood)
common_nbhds <- names(nbhd_counts[nbhd_counts >= 20])

nbhd_avg <- aggregate(
  sale_price ~ neighborhood,
  data = housing[housing$neighborhood %in% common_nbhds, ],
  FUN = mean
)
nbhd_avg$sale_price <- round(nbhd_avg$sale_price, 0)
top5 <- nbhd_avg[order(-nbhd_avg$sale_price), ][1:5, ]
print(top5)

# A simple chart: average sale price for every neighborhood with at
# least 20 sales, sorted from lowest to highest.
nbhd_avg$neighborhood <- factor(
  nbhd_avg$neighborhood,
  levels = nbhd_avg$neighborhood[order(nbhd_avg$sale_price)]
)

p <- ggplot(nbhd_avg, aes(x = neighborhood, y = sale_price)) +
  geom_col(fill = "#27496D") +
  coord_flip() +
  scale_y_continuous(labels = scales::label_dollar()) +
  labs(
    title = "Average Home Sale Price by Ames Neighborhood",
    x = NULL, y = "Average Sale Price",
    caption = "Data: ames_housing.csv, 2,413 normal-condition sales, 2006-2010 (De Cock, 2011)."
  ) +
  theme_minimal(base_size = 11)
p

ggsave("module1_avg_price_by_neighborhood.png", p, width = 8, height = 7, dpi = 200)
