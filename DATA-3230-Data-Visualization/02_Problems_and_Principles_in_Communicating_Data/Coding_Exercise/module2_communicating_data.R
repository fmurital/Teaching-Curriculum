# Module 2: Problems and Principles in Communicating Data
# Data Visualization (DATA 3230)
#
# This module runs entirely on the housing dataset (ames_housing.csv), the
# same file introduced in Module 1. Every chart and every printed number
# below comes from that one real file; nothing here is simulated. Run this
# script yourself to reproduce every number and chart on the Module 2
# slides.

library(ggplot2)
library(readr)

housing <- read_csv("ames_housing.csv", show_col_types = FALSE)

theme_deck <- theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))

# ------------------------------------------------------------------
# Same real question Module 1 used: among Ames neighborhoods with at
# least 20 sales in this data, how many sales does each one have, and
# what is the average sale price? This module reuses that same real
# subset (23 qualifying neighborhoods) to show the same information
# told well and told poorly.
# ------------------------------------------------------------------
nbhd_counts_tbl <- table(housing$neighborhood)
common_nbhds <- names(nbhd_counts_tbl[nbhd_counts_tbl >= 20])
length(common_nbhds)   # 23 qualifying neighborhoods

nbhd_counts <- data.frame(
  neighborhood = common_nbhds,
  n = as.integer(nbhd_counts_tbl[common_nbhds])
)
print(nbhd_counts[order(-nbhd_counts$n), ])

nbhd_avg <- aggregate(
  sale_price ~ neighborhood,
  data = housing[housing$neighborhood %in% common_nbhds, ],
  FUN = mean
)
nbhd_avg$sale_price <- round(nbhd_avg$sale_price, 0)

# ------------------------------------------------------------------
# The same pie-chart problem Dr. Brown raises in his own course, shown
# here with our own real data instead of a stock image: 23 categories
# is already too many for a pie chart to communicate anything at a
# glance. This is deliberately the "bad" example.
# ------------------------------------------------------------------
p_bad_pie <- ggplot(nbhd_counts, aes(x = "", y = n, fill = neighborhood)) +
  geom_col(width = 1, color = "white") +
  coord_polar(theta = "y") +
  labs(title = "Sales by Neighborhood", x = NULL, y = NULL) +
  theme_void(base_size = 11) +
  theme(plot.title = element_text(face = "bold", hjust = 0.5))
ggsave("module2_bad_pie.png", p_bad_pie, width = 7, height = 6, dpi = 200)

# The same information, as a sorted horizontal bar chart: the "good"
# alternative. Every one of the 23 bars is readable and the ordering
# itself carries information the pie chart could not show at all.
nbhd_counts$neighborhood <- factor(
  nbhd_counts$neighborhood,
  levels = nbhd_counts$neighborhood[order(nbhd_counts$n)]
)
p_good_bar <- ggplot(nbhd_counts, aes(x = neighborhood, y = n)) +
  geom_col(fill = "#27496D") +
  coord_flip() +
  labs(
    title = "Number of Sales by Ames Neighborhood",
    x = NULL, y = "Number of Sales (2006-2010)"
  ) +
  theme_deck
ggsave("module2_good_bar.png", p_good_bar, width = 8, height = 7, dpi = 200)

# ------------------------------------------------------------------
# Principle 4 (Design for Aesthetics): the same average-sale-price
# chart, rendered badly and then well. Same data, same geom, same
# numbers. What changes is color, theme, labeling, and ordering.
# ------------------------------------------------------------------
nbhd_avg_unordered <- nbhd_avg  # keep neighborhood as plain character, unordered
p_aes_bad <- ggplot(nbhd_avg_unordered, aes(x = neighborhood, y = sale_price, fill = neighborhood)) +
  geom_col(show.legend = TRUE) +
  labs(title = "avg sale price by nbhd", x = "neighborhood", y = "sale_price") +
  theme_gray(base_size = 10) +
  theme(
    axis.text.x = element_text(angle = 90, vjust = 0.5, size = 7),
    legend.position = "right",
    legend.key.size = unit(0.3, "cm"),
    panel.grid.major = element_line(color = "grey70"),
    panel.grid.minor = element_line(color = "grey85")
  )
ggsave("module2_aesthetic_bad.png", p_aes_bad, width = 8, height = 6, dpi = 200)

nbhd_avg$neighborhood <- factor(
  nbhd_avg$neighborhood,
  levels = nbhd_avg$neighborhood[order(nbhd_avg$sale_price)]
)
p_aes_good <- ggplot(nbhd_avg, aes(x = neighborhood, y = sale_price)) +
  geom_col(fill = "#27496D") +
  coord_flip() +
  scale_y_continuous(labels = scales::label_dollar()) +
  labs(
    title = "Average Home Sale Price by Ames Neighborhood",
    x = NULL, y = "Average Sale Price",
    caption = "Data: ames_housing.csv, 2,413 normal-condition sales, 2006-2010 (De Cock, 2011)."
  ) +
  theme_deck
ggsave("module2_aesthetic_good.png", p_aes_good, width = 8, height = 7, dpi = 200)

# ------------------------------------------------------------------
# Principle 3 (variable types), using three real columns already in
# this dataset: sale_price (quantitative), overall_qual (ordinal, a
# 1-10 condition rating with real order), neighborhood (nominal, no
# inherent order). This is the real printed output used on that slide.
# ------------------------------------------------------------------
class(housing$sale_price)
summary(housing$sale_price)

class(housing$overall_qual)
table(housing$overall_qual)

class(housing$neighborhood)
length(unique(housing$neighborhood))

# ------------------------------------------------------------------
# Principle 2 (Use the Right Data) worked question: does combining all
# five sale years change the picture, or would a single year tell a
# different story? Real check, not asserted.
# ------------------------------------------------------------------
year_counts <- table(housing$yr_sold)
print(year_counts)

by_year <- aggregate(sale_price ~ yr_sold, data = housing, FUN = mean)
by_year$sale_price <- round(by_year$sale_price, 0)
print(by_year)

# ------------------------------------------------------------------
# Organizing Data (tidy format) illustration, using this same dataset
# instead of a generic textbook example: six real rows, each one sale,
# each column one variable.
# ------------------------------------------------------------------
head(housing[, c("sale_price", "neighborhood", "gr_liv_area", "overall_qual")], 6)

# The semantic-problem example: neighborhood codes like "NAmes" and
# "NridgHt" are exactly the kind of symbol a general audience will not
# recognize without a legend, the real-data version of Dr. Brown's
# "team logo instead of team name" point.
head(sort(unique(housing$neighborhood)), 6)

cat("All Module 2 charts written.\n")
