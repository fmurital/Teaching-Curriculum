# Module 1: Getting Started with R and RStudio
# Data Visualization (DATA 3230)
#
# This script sets up the R environment used all semester and takes a
# first look at the two real datasets this course runs on all term: a
# real Ames, Iowa housing-sale dataset and a real secondary-school
# student performance dataset. Full source and license details for both
# are in Curriculum_Resources/Datasets/README.md.
#
# Every code+output pair shown on the Module 1 lecture slides traces
# back to this exact script; run it yourself to reproduce every number
# and chart in the deck.

# install.packages(c("ggplot2", "readr"))  # run once, then comment out
library(ggplot2)
library(readr)

# The two running datasets for this course. No data is simulated: both
# come from the real, cited public sources documented in
# Curriculum_Resources/Datasets/README.md. Running read_csv() without
# show_col_types = FALSE (as below) prints readr's column-specification
# message, which is what students actually see the first time; the rest
# of this script suppresses it for cleaner output.
housing <- read_csv("ames_housing.csv")

dim(housing)    # 2413 home sales, 18 variables
names(housing)
head(housing[, c("sale_price", "neighborhood", "gr_liv_area", "bedroom_abvgr")], 3)
str(housing)
summary(housing$sale_price)

students <- read_csv("student_performance_math.csv", show_col_types = FALSE)
dim(students)   # 395 students, 33 variables
names(students)
summary(students$G3)

# A first, purely descriptive question: which Ames neighborhoods had the
# highest average sale price, among neighborhoods with at least 20 sales
# in this data?
nbhd_counts <- table(housing$neighborhood)
common_nbhds <- names(nbhd_counts[nbhd_counts >= 20])
length(common_nbhds)   # 23 qualifying neighborhoods

nbhd_avg <- aggregate(
  sale_price ~ neighborhood,
  data = housing[housing$neighborhood %in% common_nbhds, ],
  FUN = mean
)
nbhd_avg$sale_price <- round(nbhd_avg$sale_price, 0)
top5 <- nbhd_avg[order(-nbhd_avg$sale_price), ][1:5, ]
print(top5)

full_sorted <- nbhd_avg[order(-nbhd_avg$sale_price), ]
print(full_sorted)   # all 23 neighborhoods, highest to lowest

# NoRidge's average versus the lowest-average qualifying neighborhood
# (MeadowV): where "more than threefold difference" on the slides comes
# from.
round(max(nbhd_avg$sale_price) / min(nbhd_avg$sale_price), 2)

class(housing$neighborhood)   # "character", before conversion

# A simple chart: average sale price for every neighborhood with at
# least 20 sales, sorted from lowest to highest.
nbhd_avg$neighborhood <- factor(
  nbhd_avg$neighborhood,
  levels = nbhd_avg$neighborhood[order(nbhd_avg$sale_price)]
)
class(nbhd_avg$neighborhood)   # "factor", after conversion
head(levels(nbhd_avg$neighborhood), 5)

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

# Practice-exercise reveal: the same aggregate() pattern applied to
# gr_liv_area (above-grade living area) instead of sale_price.
gla_avg <- aggregate(
  gr_liv_area ~ neighborhood,
  data = housing[housing$neighborhood %in% common_nbhds, ],
  FUN = mean
)
gla_avg$gr_liv_area <- round(gla_avg$gr_liv_area, 0)
print(gla_avg[order(-gla_avg$gr_liv_area), ][1:5, ])

# Extension / second worked example: does more weekly study time come
# with a higher final grade, in this real data?
hi <- students[students$studytime > 2, ]
lo <- students[students$studytime <= 2, ]
nrow(hi)                 # 92
nrow(lo)                 # 303
round(mean(hi$G3), 2)    # 11.36
round(mean(lo$G3), 2)    # 10.13

# Reproducibility callout: anyone with ames_housing.csv can rerun this
# exact script and get these exact numbers back.
class(housing)
nrow(housing)
ncol(housing)

# Four additional charts shown on the slides, all from this same real data.
theme_deck <- theme_minimal(base_size = 13) + theme(plot.title = element_text(face = "bold"))

# Sale price distribution, with mean/median marked (shows the right skew
# referenced right after the summary() slide).
p_price <- ggplot(housing, aes(x = sale_price)) +
  geom_histogram(bins = 40, fill = "#27496D", color = "white") +
  geom_vline(aes(xintercept = median(sale_price)), color = "#E4572E", linewidth = 1) +
  geom_vline(aes(xintercept = mean(sale_price)), color = "#16213E", linewidth = 1, linetype = "dashed") +
  scale_x_continuous(labels = scales::label_dollar()) +
  labs(title = "Distribution of Sale Price, All 2,413 Homes", x = "Sale Price", y = "Number of Sales") +
  theme_deck
ggsave("module1_sale_price_distribution.png", p_price, width = 8, height = 5.3, dpi = 200)

# Average living area by neighborhood, same chart recipe as the sale-price
# chart (pairs with the gr_liv_area practice-exercise reveal).
gla_avg$neighborhood <- factor(gla_avg$neighborhood, levels = gla_avg$neighborhood[order(gla_avg$gr_liv_area)])
p_gla <- ggplot(gla_avg, aes(x = neighborhood, y = gr_liv_area)) +
  geom_col(fill = "#E4572E") +
  coord_flip() +
  labs(title = "Average Living Area (sq ft) by Ames Neighborhood", x = NULL, y = "Average Above-Grade Living Area (sq ft)") +
  theme_deck
ggsave("module1_avg_living_area_by_neighborhood.png", p_gla, width = 8, height = 7, dpi = 200)

# G3 (final grade) distribution for the second dataset.
p_g3 <- ggplot(students, aes(x = G3)) +
  geom_histogram(binwidth = 1, fill = "#27496D", color = "white") +
  scale_x_continuous(breaks = seq(0, 20, 2)) +
  labs(title = "Distribution of Final Grade (G3), All 395 Students", x = "Final Grade (0-20 scale)", y = "Number of Students") +
  theme_deck
ggsave("module1_g3_distribution.png", p_g3, width = 8, height = 5.3, dpi = 200)

# G3 by study-time group, as a boxplot (the same hi/lo comparison above,
# shown as a chart instead of two printed numbers).
students$study_group <- factor(
  ifelse(students$studytime > 2, "More than 2 hrs/week", "2 hrs/week or less"),
  levels = c("2 hrs/week or less", "More than 2 hrs/week")
)
p_studytime <- ggplot(students, aes(x = study_group, y = G3, fill = study_group)) +
  geom_boxplot(show.legend = FALSE) +
  scale_fill_manual(values = c("#AEBBD1", "#E4572E")) +
  labs(title = "Final Grade by Weekly Study Time", x = NULL, y = "Final Grade (G3, 0-20 scale)") +
  theme_deck
ggsave("module1_g3_by_studytime.png", p_studytime, width = 7, height = 5.3, dpi = 200)
