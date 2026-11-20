# Module 4: Communicating Amounts: Bar and Dot Charts
# Data Visualization (DATA 3230)
#
# This module runs entirely on the housing dataset (ames_housing.csv), per
# the course's one-dataset lecture rule. Every chart and every printed
# number below comes from that one real file; nothing here is simulated.
# Run this script yourself to reproduce every number and chart on the
# Module 4 slides.

library(ggplot2)
library(readr)
library(scales)

housing <- read_csv("ames_housing.csv", show_col_types = FALSE)

theme_deck <- theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))

# ------------------------------------------------------------------
# Primary real question for this module: among the 23 Ames neighborhoods
# with at least 20 sales in this data, what is the average sale price?
# This is a genuine "how much" question, the communication goal this
# module is about.
# ------------------------------------------------------------------
nbhd_counts_tbl <- table(housing$neighborhood)
common_nbhds <- names(nbhd_counts_tbl[nbhd_counts_tbl >= 20])
length(common_nbhds)  # 23 qualifying neighborhoods

nbhd_avg <- aggregate(
  sale_price ~ neighborhood,
  data = housing[housing$neighborhood %in% common_nbhds, ],
  FUN = mean
)
nbhd_avg$sale_price <- round(nbhd_avg$sale_price, 0)
print(nbhd_avg[order(-nbhd_avg$sale_price), ])

# ------------------------------------------------------------------
# Segment B: the rough default bar chart for this question, unsorted,
# unlabeled, in ggplot2's default appearance.
# ------------------------------------------------------------------
p_bar_rough <- ggplot(nbhd_avg, aes(x = neighborhood, y = sale_price)) +
  geom_col() +
  labs(title = "avg sale price by nbhd", x = "neighborhood", y = "sale_price") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 7))
ggsave("module4_bar_rough.png", p_bar_rough, width = 8, height = 6, dpi = 200)

# The finished bar chart: sorted descending, dollar-formatted direct data
# labels on every bar (an annotation, not just an axis), a real title,
# clean labels, one intentional color.
nbhd_avg$neighborhood <- factor(
  nbhd_avg$neighborhood,
  levels = nbhd_avg$neighborhood[order(nbhd_avg$sale_price)]
)
p_bar_finished <- ggplot(nbhd_avg, aes(x = neighborhood, y = sale_price)) +
  geom_col(fill = "#27496D") +
  geom_text(aes(label = label_dollar()(sale_price)), hjust = -0.1, size = 3.0, color = "#16213E") +
  coord_flip() +
  scale_y_continuous(labels = label_dollar(), expand = expansion(mult = c(0, 0.22))) +
  labs(
    title = "Average Home Sale Price by Ames Neighborhood",
    x = NULL, y = "Average Sale Price",
    caption = "Data: ames_housing.csv, 2,413 normal-condition sales, 2006-2010 (De Cock, 2011)."
  ) +
  theme_deck
ggsave("module4_bar_finished.png", p_bar_finished, width = 8.5, height = 7.5, dpi = 200)

# ------------------------------------------------------------------
# Segment C: the exact same real numbers as a Cleveland dot plot
# (geom_point instead of geom_col), the classic bar-chart alternative
# for amount comparisons, with the same sort order and annotations.
# ------------------------------------------------------------------
p_dot <- ggplot(nbhd_avg, aes(x = sale_price, y = neighborhood)) +
  geom_segment(aes(x = 0, xend = sale_price, y = neighborhood, yend = neighborhood), color = "#AEBBD1") +
  geom_point(size = 3, color = "#27496D") +
  geom_text(aes(label = label_dollar()(sale_price)), hjust = -0.25, size = 3.0, color = "#16213E") +
  scale_x_continuous(labels = label_dollar(), expand = expansion(mult = c(0, 0.25))) +
  labs(
    title = "Average Home Sale Price by Ames Neighborhood (Dot Plot)",
    x = "Average Sale Price", y = NULL,
    caption = "Same real averages as the bar chart. Data: ames_housing.csv (De Cock, 2011)."
  ) +
  theme_deck
ggsave("module4_dot_finished.png", p_dot, width = 8.5, height = 7.5, dpi = 200)

# ------------------------------------------------------------------
# Segment D: annotation / highlighting one specific category. Here we
# call out NoRidge, the single highest-average-price neighborhood in
# this real data, against the rest.
# ------------------------------------------------------------------
nbhd_avg$highlight <- ifelse(nbhd_avg$neighborhood == "NoRidge", "Highest Average", "All Other Neighborhoods")
p_highlight <- ggplot(nbhd_avg, aes(x = neighborhood, y = sale_price, fill = highlight)) +
  geom_col() +
  geom_text(aes(label = label_dollar()(sale_price)), hjust = -0.1, size = 3.0, color = "#16213E") +
  coord_flip() +
  scale_y_continuous(labels = label_dollar(), expand = expansion(mult = c(0, 0.22))) +
  scale_fill_manual(values = c("Highest Average" = "#E4572E", "All Other Neighborhoods" = "#AEBBD1")) +
  labs(
    title = "NoRidge Leads All 23 Qualifying Neighborhoods",
    x = NULL, y = "Average Sale Price", fill = NULL
  ) +
  theme_deck +
  theme(legend.position = "top")
ggsave("module4_highlight.png", p_highlight, width = 8.5, height = 7.5, dpi = 200)

# ------------------------------------------------------------------
# Segment E: ordering strategies on a second, independent real "how
# much" question: average sale price by building type. Three versions
# of the same five real numbers: alphabetical (the rough default),
# ascending, and descending.
# ------------------------------------------------------------------
bldg_avg <- aggregate(sale_price ~ bldg_type, data = housing, FUN = mean)
bldg_avg$sale_price <- round(bldg_avg$sale_price, 0)
print(bldg_avg[order(-bldg_avg$sale_price), ])

bldg_label_map <- c(
  "1Fam" = "Single-Family", "2fmCon" = "Two-Family Conversion",
  "Duplex" = "Duplex", "Twnhs" = "Townhouse", "TwnhsE" = "Townhouse End Unit"
)
bldg_avg$label <- bldg_label_map[bldg_avg$bldg_type]

p_order_alpha <- ggplot(bldg_avg, aes(x = label, y = sale_price)) +
  geom_col(fill = "#27496D") + coord_flip() +
  scale_y_continuous(labels = label_dollar()) +
  labs(title = "Ordered Alphabetically (the Default)", x = NULL, y = "Average Sale Price") +
  theme_deck
ggsave("module4_order_alpha.png", p_order_alpha, width = 7, height = 5, dpi = 200)

bldg_avg_desc <- bldg_avg
bldg_avg_desc$label <- factor(bldg_avg_desc$label, levels = bldg_avg_desc$label[order(bldg_avg_desc$sale_price)])
p_order_desc <- ggplot(bldg_avg_desc, aes(x = label, y = sale_price)) +
  geom_col(fill = "#27496D") + coord_flip() +
  scale_y_continuous(labels = label_dollar()) +
  labs(title = "Ordered by Value (Highest on Top)", x = NULL, y = "Average Sale Price") +
  theme_deck
ggsave("module4_order_desc.png", p_order_desc, width = 7, height = 5, dpi = 200)

cat("All Module 4 charts written.\n")
