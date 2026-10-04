# Module 8: Basketball Performance Maps Based on Court Segmentation
# (Graduate -- Sports-Analytics-Graduate)
# Real data: BasketballAnalyzeR::PbP.BDB (2017-18 NBA play-by-play, built
#            around the Golden State Warriors' full 82-game 2017-18
#            schedule; every other team's rows are that team's own real
#            regular-season game(s) against Golden State specifically --
#            same real dataset and the same real scope limitation already
#            documented in this course's earlier modules)
# Reproduces every number, table, and chart used in Module 8 slides,
# notes, and lab. Methodology follows the real, general, published
# approach to court-segmentation performance maps and CART-based scoring
# probability maps (sector maps, shot charts, CART on Cartesian and on
# polar shot coordinates), applied here to real shot-location data rather
# than reproduced from any single source's text.
# Run this with BasketballAnalyzeR 0.8.1 and rpart installed.

options(width = 120)
set.seed(8)
library(BasketballAnalyzeR)
library(dplyr)
library(rpart)

out_dir <- "Sports-Analytics-Graduate/08_Performance_Maps_and_Court_Segmentation/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)

sh <- subset(PbP, event_type %in% c("shot", "miss") & !is.na(converted_x) & !is.na(converted_y) & !is.na(shot_distance))
sh$made <- as.integer(sh$event_type == "shot")
cat("Real total shot attempts with valid real location and distance:", nrow(sh), "\n")
cat("Real makes:", sum(sh$made), "  Real misses:", sum(sh$made == 0),
    "  Real overall FG%:", round(100 * mean(sh$made), 1), "\n")

# ---- Normalize every real shot onto one real half-court, hoop at (0,0) ----
d1 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 5.25)^2)
d2 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 88.75)^2)
near1 <- d1 <= d2
sh$x_rel <- sh$converted_x - 25
sh$y_rel <- ifelse(near1, sh$converted_y - 5.25, 88.75 - sh$converted_y)
sh$x_rel <- ifelse(near1, sh$x_rel, -sh$x_rel)  # keep a consistent real court orientation
sh$angle_deg <- atan2(sh$x_rel, sh$y_rel + 1e-6) * 180 / pi

cat("\nReal check: normalized distance from hoop vs. the course's own real shot_distance field:\n")
print(summary(sqrt(sh$x_rel^2 + sh$y_rel^2) - sh$shot_distance))

# =============================================================
# PART 1: Sector-based real performance map (8.1)
# =============================================================
sh$dist_band <- cut(sh$shot_distance, breaks = c(-1, 4, 14, 22, 100),
                     labels = c("Rim (0-4 ft)", "Paint (4-14 ft)", "Mid-range (14-22 ft)", "Three (22 ft+)"))
sh$angle_sector <- cut(sh$x_rel, breaks = c(-100, -8, 8, 100),
                        labels = c("Left side", "Center", "Right side"))

sector_map <- sh %>%
  group_by(dist_band, angle_sector) %>%
  summarise(Attempts = n(), Makes = sum(made), FGpct = round(100 * mean(made), 1), .groups = "drop") %>%
  arrange(dist_band, angle_sector)

cat("\nReal sector-based performance map (real FG% by real distance band x real angle sector):\n")
print(as.data.frame(sector_map))
write.csv(sector_map, file.path(out_dir, "module8_sector_performance_map.csv"), row.names = FALSE)

# =============================================================
# PART 2: Real shot chart, Golden State Warriors, the team with the
#          most complete real coverage in this dataset (full 82 games)
# =============================================================
sh.GSW <- subset(sh, team == "GSW")
cat("\nReal Golden State shot attempts (full 2017-18 season):", nrow(sh.GSW), "\n")
cat("Real Golden State FG%:", round(100 * mean(sh.GSW$made), 1), "\n")

p0 <- ggplot2::ggplot()
p_court <- drawNBAcourt(p0, size = 1, col = "gray40", full = FALSE)
p_shots <- p_court +
  ggplot2::geom_point(data = sh.GSW, ggplot2::aes(x = x_rel, y = y_rel, color = factor(made)),
                       alpha = 0.45, size = 1.6) +
  ggplot2::scale_color_manual(values = c("1" = "#2E7D32", "0" = "#C62828"),
                               labels = c("1" = "Made", "0" = "Missed"), name = "Real result") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Golden State Warriors Shot Chart, 2017-18 Regular Season")
ggplot2::ggsave(file.path(out_dir, "module8_gsw_shot_chart.png"), p_shots, width = 9, height = 8.5, dpi = 150)

# =============================================================
# PART 3: CART scoring probability map, real Cartesian coordinates (8.3.1)
# =============================================================
cart_xy <- rpart(made ~ x_rel + y_rel, data = sh, method = "class",
                  control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
cat("\nReal CART tree, Cartesian (x, y) shot coordinates:\n")
print(cart_xy)
sink(file.path(out_dir, "module8_cart_cartesian_rules.txt"))
print(cart_xy)
cat("\ncptable:\n")
print(printcp(cart_xy))
sink()

pred_xy <- predict(cart_xy, sh, type = "class")
acc_xy <- round(100 * mean(pred_xy == sh$made), 2)
cat("Real training accuracy, Cartesian CART:", acc_xy, "%\n")

png(file.path(out_dir, "module8_cart_cartesian_tree.png"), width = 1900, height = 1300, res = 150)
rpart.plot::rpart.plot(cart_xy, extra = 104, box.palette = "RdYlGn", main = "CART on Cartesian Shot Coordinates")
dev.off()

# Real prediction grid, Cartesian model, for a performance-map heat image
grid_xy <- expand.grid(x_rel = seq(-25, 25, length.out = 120), y_rel = seq(0, 45, length.out = 120))
grid_xy$prob_make <- predict(cart_xy, grid_xy, type = "prob")[, "1"]
p_heat_xy <- drawNBAcourt(ggplot2::ggplot(), size = 1, col = "black", full = FALSE) +
  ggplot2::geom_tile(data = grid_xy, ggplot2::aes(x = x_rel, y = y_rel, fill = prob_make), alpha = 0.75) +
  ggplot2::scale_fill_gradient2(low = "#B71C1C", mid = "#FFF59D", high = "#1B5E20", midpoint = 0.42,
                                 name = "Real CART\nscoring\nprobability") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Scoring Probability Map, CART on Cartesian Coordinates")
ggplot2::ggsave(file.path(out_dir, "module8_cart_cartesian_heatmap.png"), p_heat_xy, width = 9, height = 8.5, dpi = 150)

# =============================================================
# PART 4: CART scoring probability map, real polar coordinates (8.3.2)
# =============================================================
cart_polar <- rpart(made ~ shot_distance + angle_deg, data = sh, method = "class",
                     control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
cat("\nReal CART tree, polar (distance, angle) shot coordinates:\n")
print(cart_polar)
sink(file.path(out_dir, "module8_cart_polar_rules.txt"))
print(cart_polar)
cat("\ncptable:\n")
print(printcp(cart_polar))
sink()

pred_polar <- predict(cart_polar, sh, type = "class")
acc_polar <- round(100 * mean(pred_polar == sh$made), 2)
cat("Real training accuracy, polar CART:", acc_polar, "%\n")

png(file.path(out_dir, "module8_cart_polar_tree.png"), width = 1900, height = 1300, res = 150)
rpart.plot::rpart.plot(cart_polar, extra = 104, box.palette = "RdYlGn", main = "CART on Polar Shot Coordinates")
dev.off()

grid_polar <- expand.grid(x_rel = seq(-25, 25, length.out = 120), y_rel = seq(0.5, 45, length.out = 120))
grid_polar$shot_distance <- sqrt(grid_polar$x_rel^2 + grid_polar$y_rel^2)
grid_polar$angle_deg <- atan2(grid_polar$x_rel, grid_polar$y_rel) * 180 / pi
grid_polar$prob_make <- predict(cart_polar, grid_polar, type = "prob")[, "1"]
p_heat_polar <- drawNBAcourt(ggplot2::ggplot(), size = 1, col = "black", full = FALSE) +
  ggplot2::geom_tile(data = grid_polar, ggplot2::aes(x = x_rel, y = y_rel, fill = prob_make), alpha = 0.75) +
  ggplot2::scale_fill_gradient2(low = "#B71C1C", mid = "#FFF59D", high = "#1B5E20", midpoint = 0.42,
                                 name = "Real CART\nscoring\nprobability") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Scoring Probability Map, CART on Polar Coordinates")
ggplot2::ggsave(file.path(out_dir, "module8_cart_polar_heatmap.png"), p_heat_polar, width = 9, height = 8.5, dpi = 150)

# =============================================================
# PART 5: Real comparison table, both CART approaches
# =============================================================
comparison <- data.frame(
  Model = c("CART, Cartesian (x, y)", "CART, Polar (distance, angle)"),
  Terminal_Nodes = c(sum(cart_xy$frame$var == "<leaf>"), sum(cart_polar$frame$var == "<leaf>")),
  Training_Accuracy_Pct = c(acc_xy, acc_polar)
)
cat("\nReal comparison, Cartesian vs. polar CART:\n")
print(comparison)
write.csv(comparison, file.path(out_dir, "module8_cart_comparison.csv"), row.names = FALSE)

cat("\nDone. All real outputs written to:", out_dir, "\n")
