# Module 3: The Grammar of Graphics / Introduction to ggplot2
# Data Visualization (DATA 3230)
#
# Per the course blueprint, this module opens with one deliberately quick
# example on the built-in mpg dataset, just to show the bare three-piece
# grammar (data + aes + geom) on the single most common teaching dataset
# for this exact idea, before returning to our own housing data for every
# other example in the module. Every other chart and printed number below
# comes from ames_housing.csv; nothing here is simulated. Run this script
# yourself to reproduce every number and chart on the Module 3 slides.

library(ggplot2)
library(readr)
library(scales)

housing <- read_csv("ames_housing.csv", show_col_types = FALSE)

theme_deck <- theme_minimal(base_size = 13) +
  theme(plot.title = element_text(face = "bold"))

# ------------------------------------------------------------------
# Segment A: the grammar's three required pieces, shown first on the
# built-in mpg dataset (234 real cars, already in every R install via
# ggplot2). This is the one deliberate exception to the housing-only
# rule in this course: a single, bare, three-line example before we
# return to housing for the rest of the module.
# ------------------------------------------------------------------
p_mpg_first <- ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()
ggsave("module3_mpg_first_plot.png", p_mpg_first, width = 7, height = 5.5, dpi = 200)

# ------------------------------------------------------------------
# Segment B: the exact same three-piece grammar, now on our own real
# housing data: above-ground living area (sq ft) versus sale price.
# First as ggplot2's own default output (the "rough" first look).
# ------------------------------------------------------------------
p_housing_first_rough <- ggplot(housing, aes(x = gr_liv_area, y = sale_price)) +
  geom_point()
ggsave("module3_housing_first_rough.png", p_housing_first_rough, width = 7.5, height = 6, dpi = 200)

# The same real plot, finished: clean title-case axis titles instead of
# the raw column names, a real title, and a dollar-formatted y-axis so
# the price axis never has to be read against a bare unlabeled number.
p_housing_first_finished <- ggplot(housing, aes(x = gr_liv_area, y = sale_price)) +
  geom_point(color = "#27496D", alpha = 0.5) +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "Sale Price by Above-Ground Living Area",
    x = "Above-Ground Living Area (Square Feet)",
    y = "Sale Price"
  ) +
  theme_deck
ggsave("module3_housing_first_finished.png", p_housing_first_finished, width = 7.5, height = 6, dpi = 200)

# ------------------------------------------------------------------
# Segment C: mapping variables to aesthetics. Four real mappings onto
# the exact same scatterplot: color, size, alpha, and shape. bldg_type
# has five real categories in this data (checked directly below),
# which is well within a readable shape palette.
# ------------------------------------------------------------------
table(housing$bldg_type)

p_aes_color <- ggplot(housing, aes(x = gr_liv_area, y = sale_price, color = bldg_type)) +
  geom_point(alpha = 0.6) +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "Sale Price by Living Area, Colored by Building Type",
    x = "Above-Ground Living Area (Square Feet)",
    y = "Sale Price",
    color = "Building Type"
  ) +
  theme_deck
ggsave("module3_aes_color.png", p_aes_color, width = 8, height = 6, dpi = 200)

p_aes_size <- ggplot(housing, aes(x = gr_liv_area, y = sale_price, size = overall_qual)) +
  geom_point(alpha = 0.4, color = "#27496D") +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "Sale Price by Living Area, Sized by Overall Quality",
    x = "Above-Ground Living Area (Square Feet)",
    y = "Sale Price",
    size = "Overall Quality (1-10)"
  ) +
  theme_deck
ggsave("module3_aes_size.png", p_aes_size, width = 8, height = 6, dpi = 200)

p_aes_shape <- ggplot(housing, aes(x = gr_liv_area, y = sale_price, shape = bldg_type)) +
  geom_point(alpha = 0.6, color = "#27496D") +
  scale_y_continuous(labels = label_dollar()) +
  labs(
    title = "Sale Price by Living Area, Shaped by Building Type",
    x = "Above-Ground Living Area (Square Feet)",
    y = "Sale Price",
    shape = "Building Type"
  ) +
  theme_deck
ggsave("module3_aes_shape.png", p_aes_shape, width = 8, height = 6, dpi = 200)

# Mapped color (data-driven, inside aes()) versus set color (the same
# fixed navy for every point, outside aes()) -- the exact distinction
# that trips students up first.
p_aes_mapped <- ggplot(housing, aes(x = gr_liv_area, y = sale_price, color = bldg_type)) +
  geom_point(alpha = 0.6) +
  scale_y_continuous(labels = label_dollar()) +
  labs(title = "Color Mapped to Building Type", x = "Above-Ground Living Area (Square Feet)", y = "Sale Price", color = "Building Type") +
  theme_deck
ggsave("module3_color_mapped.png", p_aes_mapped, width = 7.5, height = 6, dpi = 200)

p_aes_set <- ggplot(housing, aes(x = gr_liv_area, y = sale_price)) +
  geom_point(alpha = 0.6, color = "#27496D") +
  scale_y_continuous(labels = label_dollar()) +
  labs(title = "Color Set to a Single Navy for Every Point", x = "Above-Ground Living Area (Square Feet)", y = "Sale Price") +
  theme_deck
ggsave("module3_color_set.png", p_aes_set, width = 7.5, height = 6, dpi = 200)

# ------------------------------------------------------------------
# Segment D: a bar chart of counts by building type. First the rough,
# default version (this is the real printed count table used on the
# live-coding slide), then the finished version.
# ------------------------------------------------------------------
bldg_counts_tbl <- table(housing$bldg_type)
print(bldg_counts_tbl)

p_bar_rough <- ggplot(housing, aes(x = bldg_type)) +
  geom_bar() +
  labs(title = "count by bldg_type", x = "bldg_type", y = "count")
ggsave("module3_bar_rough.png", p_bar_rough, width = 7.5, height = 6, dpi = 200)

bldg_counts <- data.frame(
  bldg_type = names(bldg_counts_tbl),
  n = as.integer(bldg_counts_tbl)
)
bldg_label_map <- c(
  "1Fam" = "Single-Family",
  "2fmCon" = "Two-Family Conversion",
  "Duplex" = "Duplex",
  "Twnhs" = "Townhouse",
  "TwnhsE" = "Townhouse End Unit"
)
bldg_counts$label <- bldg_label_map[bldg_counts$bldg_type]
bldg_counts$label <- factor(bldg_counts$label, levels = bldg_counts$label[order(bldg_counts$n)])

p_bar_finished <- ggplot(bldg_counts, aes(x = label, y = n)) +
  geom_col(fill = "#27496D") +
  geom_text(aes(label = comma(n)), hjust = -0.15, size = 3.3, color = "#16213E") +
  coord_flip() +
  scale_y_continuous(labels = comma, expand = expansion(mult = c(0, 0.18))) +
  labs(
    title = "Number of Home Sales by Building Type",
    x = NULL, y = "Number of Sales (2006-2010)",
    caption = "Data: ames_housing.csv, 2,413 normal-condition sales, 2006-2010 (De Cock, 2011)."
  ) +
  theme_deck
ggsave("module3_bar_finished.png", p_bar_finished, width = 8, height = 6, dpi = 200)

# ------------------------------------------------------------------
# Segment E: the same finished bar chart under four different complete
# themes, to show that a theme is its own grammar layer, independent
# of the data or geom choices above it.
# ------------------------------------------------------------------
p_theme_gray <- ggplot(bldg_counts, aes(x = label, y = n)) +
  geom_col(fill = "#27496D") + coord_flip() +
  scale_y_continuous(labels = comma) +
  labs(title = "theme_gray() (ggplot2's Default)", x = NULL, y = "Number of Sales") +
  theme_gray(base_size = 11)
ggsave("module3_theme_gray.png", p_theme_gray, width = 6, height = 5, dpi = 200)

p_theme_minimal <- p_theme_gray + labs(title = "theme_minimal()") + theme_minimal(base_size = 11)
ggsave("module3_theme_minimal.png", p_theme_minimal, width = 6, height = 5, dpi = 200)

p_theme_classic <- p_theme_gray + labs(title = "theme_classic()") + theme_classic(base_size = 11)
ggsave("module3_theme_classic.png", p_theme_classic, width = 6, height = 5, dpi = 200)

p_theme_bw <- p_theme_gray + labs(title = "theme_bw()") + theme_bw(base_size = 11)
ggsave("module3_theme_bw.png", p_theme_bw, width = 6, height = 5, dpi = 200)

# ------------------------------------------------------------------
# Segment F: scales as their own grammar layer. A manual fill scale
# (scale_fill_manual) with our own brand colors, applied to the same
# building-type bars once mapped by fill instead of a single set color.
# ------------------------------------------------------------------
p_scale_manual <- ggplot(bldg_counts, aes(x = label, y = n, fill = label)) +
  geom_col(show.legend = FALSE) +
  coord_flip() +
  scale_y_continuous(labels = comma) +
  scale_fill_manual(values = c(
    "Single-Family" = "#27496D",
    "Townhouse End Unit" = "#4C7093",
    "Townhouse" = "#7FA1BE",
    "Duplex" = "#AEBBD1",
    "Two-Family Conversion" = "#E4572E"
  )) +
  labs(
    title = "Number of Home Sales by Building Type",
    x = NULL, y = "Number of Sales (2006-2010)"
  ) +
  theme_deck
ggsave("module3_scale_manual.png", p_scale_manual, width = 8, height = 6, dpi = 200)

cat("All Module 3 charts written.\n")
