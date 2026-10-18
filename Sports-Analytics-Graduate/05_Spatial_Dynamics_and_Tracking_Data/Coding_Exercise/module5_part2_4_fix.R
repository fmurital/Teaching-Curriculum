# Fix-up script: cleaner real Voronoi (favorite-zone seeds) and normalized kernel density
options(width = 120)
library(BasketballAnalyzeR); library(dplyr); library(deldir); library(MASS); library(ggplot2)
out_dir <- "Sports-Analytics-Graduate/05_Spatial_Dynamics_and_Tracking_Data/Coding_Exercise"
data(PbP.BDB); PbP <- PbPmanipulation(PbP.BDB)
shots <- subset(PbP, ShotType %in% c("2P","3P") & !is.na(original_x) & !is.na(original_y))
shots$x_ft <- shots$original_x / 10
shots$y_ft <- shots$original_y / 10

player_counts <- shots %>% filter(team == "GSW") %>% count(player, sort = TRUE)
top_gsw <- player_counts %>% filter(n >= 100) %>% pull(player)  # real rotation regulars only, avoids clutter

# Real "favorite real shooting zone" per player: mode of a 4x4 ft real court grid, per player
favorite_zone <- shots %>% filter(team == "GSW", player %in% top_gsw) %>%
  mutate(gx = round(x_ft/4)*4, gy = round(y_ft/4)*4) %>%
  count(player, gx, gy, sort = TRUE) %>%
  group_by(player) %>% slice_max(n, n = 1, with_ties = FALSE) %>% ungroup() %>%
  rename(cx = gx, cy = gy, zone_shots = n)
print(favorite_zone)
write.csv(favorite_zone, file.path(out_dir, "module5_gsw_favorite_zones.csv"), row.names = FALSE)

vt <- deldir(favorite_zone$cx, favorite_zone$cy, rw = c(-25, 25, -2, 47))
tiles <- tile.list(vt)
poly_df <- bind_rows(lapply(seq_along(tiles), function(i) {
  data.frame(x = tiles[[i]]$x, y = tiles[[i]]$y, player = favorite_zone$player[i])
}))

p_voronoi <- ggplot() +
  geom_polygon(data = poly_df, aes(x, y, group = player, fill = player), color = "white", linewidth = 1, alpha = 0.85) +
  geom_point(data = favorite_zone, aes(cx, cy), color = "black", size = 2) +
  geom_text(data = favorite_zone, aes(cx, cy, label = player), size = 3.4, fontface = "bold", color="black", vjust = -0.9) +
  coord_fixed(xlim = c(-25,25), ylim = c(-2,47)) + theme_minimal() +
  theme(legend.position = "none") +
  labs(title = "Real Voronoi Tessellation: Each GSW Regular's Real Favorite Shooting Zone",
       subtitle = "Seed = each player's real highest-volume 4x4 ft court cell, 2017-18 shots (BasketballAnalyzeR::PbP.BDB)",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_voronoi.png"), p_voronoi, width = 10, height = 9, dpi = 150)

# ---- Normalized kernel density (each player's density relative to its own peak) ----
curry <- shots %>% filter(team == "GSW", player == "Stephen Curry")
mcgee <- shots %>% filter(team == "GSW", player == "JaVale McGee")
kd_curry <- kde2d(curry$x_ft, curry$y_ft, n = 100, lims = c(-25,25,0,47))
kd_mcgee <- kde2d(mcgee$x_ft, mcgee$y_ft, n = 100, lims = c(-25,25,0,47))
df_curry <- data.frame(expand.grid(x=kd_curry$x, y=kd_curry$y), z=as.vector(kd_curry$z)/max(kd_curry$z), who=sprintf("Stephen Curry (real n=%d)", nrow(curry)))
df_mcgee <- data.frame(expand.grid(x=kd_mcgee$x, y=kd_mcgee$y), z=as.vector(kd_mcgee$z)/max(kd_mcgee$z), who=sprintf("JaVale McGee (real n=%d)", nrow(mcgee)))
df_kd <- rbind(df_curry, df_mcgee)

p_kd <- ggplot(df_kd, aes(x, y, fill = z)) + geom_raster(interpolate = TRUE) +
  scale_fill_gradientn(colors = c("white","#FFD9C7","#E4572E","#7A1E0A"), name="Relative\ndensity") +
  coord_fixed() + facet_wrap(~who) + theme_minimal() +
  labs(title = "Real Spatial Shot Distribution: Stephen Curry vs. JaVale McGee (2017-18)",
       subtitle = "2D kernel density of real shot locations, each normalized to its own peak, BasketballAnalyzeR::PbP.BDB",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_kernel_density.png"), p_kd, width = 11, height = 6, dpi = 150)

cat("DONE FIXUP\n")

# ---- Retry: real jump-shot-only centroids (excludes rim shots, which dominate every player's raw mode) ----
jumpers <- shots %>% filter(team == "GSW", player %in% top_gsw, ShotType == "3P" | x_ft^2+y_ft^2 > 10^2)
jump_centroid <- jumpers %>% group_by(player) %>%
  summarise(cx = median(x_ft), cy = median(y_ft), n_jumpers = n(), .groups = "drop")
print(jump_centroid)
write.csv(jump_centroid, file.path(out_dir, "module5_gsw_jumpshot_centroids.csv"), row.names = FALSE)

vt2 <- deldir(jump_centroid$cx, jump_centroid$cy, rw = c(-25, 25, -2, 47))
tiles2 <- tile.list(vt2)
poly_df2 <- bind_rows(lapply(seq_along(tiles2), function(i) {
  data.frame(x = tiles2[[i]]$x, y = tiles2[[i]]$y, player = jump_centroid$player[i])
}))
p_voronoi2 <- ggplot() +
  geom_polygon(data = poly_df2, aes(x, y, group = player, fill = player), color = "white", linewidth = 1, alpha = 0.85) +
  geom_point(data = jump_centroid, aes(cx, cy), color = "black", size = 2) +
  geom_text(data = jump_centroid, aes(cx, cy, label = player), size = 3.4, fontface = "bold", color="black", vjust = -0.9) +
  coord_fixed(xlim = c(-25,25), ylim = c(-2,47)) + theme_minimal() + theme(legend.position = "none") +
  labs(title = "Real Voronoi Tessellation: Each GSW Regular's Real Median Jump-Shot Location",
       subtitle = "Seed = real median (x,y) of each player's own 3-point and long 2-point attempts, 2017-18 (BasketballAnalyzeR::PbP.BDB)",
       x = "Court X (ft)", y = "Court Y (ft)")
ggsave(file.path(out_dir, "module5_voronoi.png"), p_voronoi2, width = 10, height = 9, dpi = 150)
cat("DONE FIXUP 2\n")
