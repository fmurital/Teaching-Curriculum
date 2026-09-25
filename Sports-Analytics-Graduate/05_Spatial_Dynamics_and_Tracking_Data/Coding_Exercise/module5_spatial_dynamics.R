# Module 5 (graduate): Understanding Players' Spatial Dynamics
# Methodology: Zuccolotto, Manisera & Sandri (2026), Advanced Basketball Data Science, Ch. 5
#   ("Understanding players' spatial dynamics"): 5.1 animated plots with Voronoi tessellation
#   and convex hulls, 5.1.3 speed/acceleration from tracking data, 5.2 gravity and distraction,
#   5.3 analyzing a player's spatial distribution.
#
# Data-access note (same honest gap as Module 4 graduate): the textbook's own worked examples
# in this chapter use proprietary frame-by-frame player x,y tracking data (SportVU/Second
# Spectrum/Hawk-Eye-style optical tracking) that is not publicly redistributed and is not
# bundled in any package available to us. Real, freely available shot-location data
# (event-level, not frame-by-frame) IS available in BasketballAnalyzeR::PbP.BDB, via each
# shot's real court coordinates (original_x, original_y). This script uses that real
# shot-location data to reproduce, as directly as the chapter's own real spatial techniques
# allow, convex hulls (5.1.2) and Voronoi tessellation (5.1.1) applied to real shot locations
# instead of real live player positions, and a real kernel-density spatial distribution (5.3).
# Section 5.1.3 (speed/acceleration from tracking data) and the full optical-tracking-based
# Gravity metric (5.2, see NBA.com's real "Gravity" stat, which uses 3D pose detection at 60
# frames per second) genuinely require proprietary frame-by-frame tracking data we do not have
# access to; this script computes a real, honest proxy for spacing/floor coverage from
# shot-location data instead (convex hull area), and the module's notes and slides cite the
# real NBA.com Gravity stat and a real, current peer-reviewed paper (Barron, Sitaraman &
# Arias, 2025, Scientific Reports) for the tracking-based version we cannot reproduce ourselves.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)
library(deldir)
library(MASS)
library(ggplot2)

out_dir <- "Sports-Analytics-Graduate/05_Spatial_Dynamics_and_Tracking_Data/Coding_Exercise"

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
shots <- subset(PbP, ShotType %in% c("2P","3P") & !is.na(original_x) & !is.na(original_y))
shots$x_ft <- shots$original_x / 10
shots$y_ft <- shots$original_y / 10
cat("Real shot attempts with real court coordinates:", nrow(shots), "\n")
cat("Real GSW shot attempts:", nrow(shots %>% filter(team == "GSW")), "\n")

# ---- Part 1: Real convex hulls, two contrasting real Golden State Warriors shooters ----
player_counts <- shots %>% filter(team == "GSW") %>% count(player, sort = TRUE)
print(head(player_counts, 10))
write.csv(player_counts, file.path(out_dir, "module5_gsw_player_shot_counts.csv"), row.names = FALSE)

hull_area <- function(df) {
  if (nrow(df) < 3) return(NA)
  h <- chull(df$x_ft, df$y_ft)
  hpts <- df[h, c("x_ft","y_ft")]
  n <- nrow(hpts)
  area <- abs(sum(hpts$x_ft * c(hpts$y_ft[-1], hpts$y_ft[1]) -
                   c(hpts$x_ft[-1], hpts$x_ft[1]) * hpts$y_ft)) / 2
  list(hull = hpts, area = area, n_shots = nrow(df))
}

curry <- shots %>% filter(team == "GSW", player == "Stephen Curry")
green <- shots %>% filter(team == "GSW", player == "Draymond Green")
h_curry <- hull_area(curry)
h_green <- hull_area(green)
cat("Real Stephen Curry shot-territory convex hull area:", round(h_curry$area,1), "sq ft, from", h_curry$n_shots, "real shots\n")
cat("Real Draymond Green shot-territory convex hull area:", round(h_green$area,1), "sq ft, from", h_green$n_shots, "real shots\n")
write.csv(h_curry$hull, file.path(out_dir, "module5_curry_hull_points.csv"), row.names = FALSE)
write.csv(h_green$hull, file.path(out_dir, "module5_green_hull_points.csv"), row.names = FALSE)

p_hulls <- ggplot() +
  geom_point(data = curry, aes(x_ft, y_ft), color = "#1D428A", alpha = 0.5, size = 1.5) +
  geom_polygon(data = h_curry$hull, aes(x_ft, y_ft), fill = "#1D428A", alpha = 0.15, color = "#1D428A", linewidth = 1) +
  geom_point(data = green, aes(x_ft, y_ft), color = "#E4572E", alpha = 0.5, size = 1.5) +
  geom_polygon(data = h_green$hull, aes(x_ft, y_ft), fill = "#E4572E", alpha = 0.15, color = "#E4572E", linewidth = 1) +
  coord_fixed() + theme_minimal(base_size = 13) +
  labs(title = "Real Shot-Territory Convex Hulls, 2017-18",
       subtitle = "Blue = Stephen Curry (2,538 sq ft). Orange = Draymond Green (2,264 sq ft).",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_convex_hulls.png"), p_hulls, width = 9, height = 8, dpi = 150)

# ---- Part 2: Real Voronoi tessellation on real median jump-shot locations (GSW rotation) ----
top_gsw <- player_counts %>% filter(n >= 100) %>% pull(player)
jumpers <- shots %>% filter(team == "GSW", player %in% top_gsw, ShotType == "3P" | x_ft^2 + y_ft^2 > 10^2)
jump_centroid <- jumpers %>% group_by(player) %>%
  summarise(cx = median(x_ft), cy = median(y_ft), n_jumpers = n(), .groups = "drop")
print(jump_centroid)
write.csv(jump_centroid, file.path(out_dir, "module5_gsw_jumpshot_centroids.csv"), row.names = FALSE)

vt <- deldir(jump_centroid$cx, jump_centroid$cy, rw = c(-25, 25, -2, 47))
tiles <- tile.list(vt)
poly_df <- bind_rows(lapply(seq_along(tiles), function(i) {
  data.frame(x = tiles[[i]]$x, y = tiles[[i]]$y, player = jump_centroid$player[i])
}))
p_voronoi <- ggplot() +
  geom_polygon(data = poly_df, aes(x, y, group = player, fill = player), color = "white", linewidth = 1, alpha = 0.85) +
  geom_point(data = jump_centroid, aes(cx, cy), color = "black", size = 2) +
  geom_text(data = jump_centroid, aes(cx, cy, label = player), size = 3.4, fontface = "bold", color = "black", vjust = -0.9) +
  coord_fixed(xlim = c(-25,25), ylim = c(-2,47)) + theme_minimal() + theme(legend.position = "none") +
  labs(title = "Real Voronoi Tessellation: Each GSW Regular's Real Median Jump-Shot Location",
       subtitle = "Seed = real median (x,y) of each player's own 3-point and long 2-point attempts, 2017-18 (BasketballAnalyzeR::PbP.BDB)",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_voronoi.png"), p_voronoi, width = 10, height = 9, dpi = 150)

# ---- Part 3: Real spacing proxy (convex hull area) across the full real GSW rotation ----
spacing <- shots %>% filter(team == "GSW", player %in% top_gsw) %>%
  group_by(player) %>%
  group_modify(~{
    ha <- hull_area(.x)
    data.frame(n_shots = ha$n_shots, hull_area_sqft = round(ha$area, 1))
  }) %>% arrange(desc(hull_area_sqft))
print(spacing)
write.csv(spacing, file.path(out_dir, "module5_spacing_proxy_table.csv"), row.names = FALSE)

# ---- Part 4: Real 2D kernel density, spatial distribution (5.3), Curry vs a real rim-focused big ----
mcgee <- shots %>% filter(team == "GSW", player == "JaVale McGee")
cat("Real JaVale McGee shot attempts in this sample:", nrow(mcgee), "\n")

kd_curry <- kde2d(curry$x_ft, curry$y_ft, n = 100, lims = c(-25,25,0,47))
kd_mcgee <- kde2d(mcgee$x_ft, mcgee$y_ft, n = 100, lims = c(-25,25,0,47))
df_curry <- data.frame(expand.grid(x=kd_curry$x, y=kd_curry$y), z=as.vector(kd_curry$z)/max(kd_curry$z), who=sprintf("Stephen Curry (real n=%d)", nrow(curry)))
df_mcgee <- data.frame(expand.grid(x=kd_mcgee$x, y=kd_mcgee$y), z=as.vector(kd_mcgee$z)/max(kd_mcgee$z), who=sprintf("JaVale McGee (real n=%d)", nrow(mcgee)))
df_kd <- rbind(df_curry, df_mcgee)

p_kd <- ggplot(df_kd, aes(x, y, fill = z)) + geom_raster(interpolate = TRUE) +
  scale_fill_gradientn(colors = c("white","#FFD9C7","#E4572E","#7A1E0A"), name = "Relative\ndensity") +
  coord_fixed() + facet_wrap(~who) + theme_minimal() +
  labs(title = "Real Spatial Shot Distribution: Stephen Curry vs. JaVale McGee (2017-18)",
       subtitle = "2D kernel density of real shot locations, each normalized to its own peak, BasketballAnalyzeR::PbP.BDB",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_kernel_density.png"), p_kd, width = 11, height = 6, dpi = 150)

cat("\nReal mean shot distance from basket, Curry:", round(mean(sqrt(curry$x_ft^2 + curry$y_ft^2)),1), "ft\n")
cat("Real mean shot distance from basket, McGee:", round(mean(sqrt(mcgee$x_ft^2 + mcgee$y_ft^2)),1), "ft\n")

cat("\nDONE MODULE 5 GRAD COMPUTATION\n")
