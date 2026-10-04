# Module 8 plot-alignment fix: drawNBAcourt() draws its half-court with
# the baseline at y = -47 and mid-court at y = 0, with the hoop centered
# at y = -41.75 (5.25 ft from the baseline, standard NBA dimensions).
# The original script's x_rel/y_rel (hoop-relative distance, y_rel = 0 AT
# the hoop) is correct for every statistical/CART use in this module, but
# plotting y_rel directly against drawNBAcourt()'s y-axis put every shot
# and the whole heat grid above the court instead of on it. This script
# only fixes the THREE plot outputs; it does not change any reported
# number, table, or CART result.
options(width = 120)
set.seed(8)
library(BasketballAnalyzeR)
library(dplyr)
library(rpart)

setwd("C:/Users/fmurital/Documents/Teaching-Curriculum")
out_dir <- "Sports-Analytics-Graduate/08_Performance_Maps_and_Court_Segmentation/Coding_Exercise"

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
sh <- subset(PbP, event_type %in% c("shot", "miss") & !is.na(converted_x) & !is.na(converted_y) & !is.na(shot_distance))
sh$made <- as.integer(sh$event_type == "shot")

d1 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 5.25)^2)
d2 <- sqrt((sh$converted_x - 25)^2 + (sh$converted_y - 88.75)^2)
near1 <- d1 <= d2
sh$x_rel <- sh$converted_x - 25
sh$y_rel <- ifelse(near1, sh$converted_y - 5.25, 88.75 - sh$converted_y)
sh$x_rel <- ifelse(near1, sh$x_rel, -sh$x_rel)
sh$angle_deg <- atan2(sh$x_rel, sh$y_rel + 1e-6) * 180 / pi

HOOP_Y <- -41.75  # drawNBAcourt()'s y-coordinate for the hoop center
sh$plot_y <- sh$y_rel + HOOP_Y

cart_xy <- rpart(made ~ x_rel + y_rel, data = sh, method = "class",
                  control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))
cart_polar <- rpart(made ~ shot_distance + angle_deg, data = sh, method = "class",
                     control = rpart.control(maxdepth = 4, cp = 0.001, minbucket = 150))

# ---- Fixed shot chart ----
sh.GSW <- subset(sh, team == "GSW")
cat("Real Golden State shot attempts (full 2017-18 season):", nrow(sh.GSW), "\n")
cat("Real Golden State FG%:", round(100 * mean(sh.GSW$made), 1), "\n")

p0 <- ggplot2::ggplot()
p_court <- drawNBAcourt(p0, size = 1, col = "gray40", full = FALSE)
p_shots <- p_court +
  ggplot2::geom_point(data = sh.GSW, ggplot2::aes(x = x_rel, y = plot_y, color = factor(made)),
                       alpha = 0.45, size = 1.6) +
  ggplot2::scale_color_manual(values = c("1" = "#2E7D32", "0" = "#C62828"),
                               labels = c("1" = "Made", "0" = "Missed"), name = "Real result") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Golden State Warriors Shot Chart, 2017-18 Regular Season")
ggplot2::ggsave(file.path(out_dir, "module8_gsw_shot_chart.png"), p_shots, width = 9, height = 8.5, dpi = 150)

# ---- Fixed Cartesian CART heatmap ----
grid_xy <- expand.grid(x_rel = seq(-25, 25, length.out = 120), y_rel = seq(0, 45, length.out = 120))
grid_xy$prob_make <- predict(cart_xy, grid_xy, type = "prob")[, "1"]
grid_xy$plot_y <- grid_xy$y_rel + HOOP_Y
p_heat_xy <- drawNBAcourt(ggplot2::ggplot(), size = 1, col = "black", full = FALSE) +
  ggplot2::geom_tile(data = grid_xy, ggplot2::aes(x = x_rel, y = plot_y, fill = prob_make), alpha = 0.75) +
  ggplot2::scale_fill_gradient2(low = "#B71C1C", mid = "#FFF59D", high = "#1B5E20", midpoint = 0.42,
                                 name = "Real CART\nscoring\nprobability") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Scoring Probability Map, CART on Cartesian Coordinates")
ggplot2::ggsave(file.path(out_dir, "module8_cart_cartesian_heatmap.png"), p_heat_xy, width = 9, height = 8.5, dpi = 150)

# ---- Fixed polar CART heatmap ----
grid_polar <- expand.grid(x_rel = seq(-25, 25, length.out = 120), y_rel = seq(0.5, 45, length.out = 120))
grid_polar$shot_distance <- sqrt(grid_polar$x_rel^2 + grid_polar$y_rel^2)
grid_polar$angle_deg <- atan2(grid_polar$x_rel, grid_polar$y_rel) * 180 / pi
grid_polar$prob_make <- predict(cart_polar, grid_polar, type = "prob")[, "1"]
grid_polar$plot_y <- grid_polar$y_rel + HOOP_Y
p_heat_polar <- drawNBAcourt(ggplot2::ggplot(), size = 1, col = "black", full = FALSE) +
  ggplot2::geom_tile(data = grid_polar, ggplot2::aes(x = x_rel, y = plot_y, fill = prob_make), alpha = 0.75) +
  ggplot2::scale_fill_gradient2(low = "#B71C1C", mid = "#FFF59D", high = "#1B5E20", midpoint = 0.42,
                                 name = "Real CART\nscoring\nprobability") +
  ggplot2::coord_fixed() + ggplot2::theme_minimal() +
  ggplot2::labs(title = "Real Scoring Probability Map, CART on Polar Coordinates")
ggplot2::ggsave(file.path(out_dir, "module8_cart_polar_heatmap.png"), p_heat_polar, width = 9, height = 8.5, dpi = 150)

cat("\nDone. Three plots regenerated with corrected hoop-aligned y-coordinates.\n")
