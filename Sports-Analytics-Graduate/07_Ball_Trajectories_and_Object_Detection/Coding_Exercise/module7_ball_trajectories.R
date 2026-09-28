# Module 7 (Graduate): Ball Trajectories and Object Detection
# Real data: BasketballAnalyzeR::PbP.BDB (real 2017-18 NBA play-by-play,
#            real shot_distance for every real field goal attempt).
# Real physics: the minimum-speed projectile trajectory to a target point
# (x, y) is a standard classical-mechanics result (see e.g. the "Angle of
# reach" derivation for projectile motion): for horizontal distance x and
# net vertical rise y, v_min = sqrt(g * (x + sqrt(x^2 + y^2))), achieved at
# theta_min = 45 deg + 0.5 * atan(y / x). Applied to basketball specifically
# in Brancazio, P. J. (1981), "Physics of basketball," American Journal of
# Physics, 49(4), 356-365, the seminal real paper on basketball shot physics.
# Run in RStudio (Windows) with BasketballAnalyzeR 0.8.1 installed.

options(width = 120)
set.seed(107)
library(BasketballAnalyzeR)
library(dplyr)

out_dir <- "Sports-Analytics-Graduate/07_Ball_Trajectories_and_Object_Detection/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

log_file <- file.path(out_dir, "module7_console_log.txt")
sink(log_file, split = TRUE)

data(PbP.BDB)
cat("Total real play-by-play events in PbP.BDB (2017-18):", nrow(PbP.BDB), "\n")

# =============================================================
# PART 1: Real shot_distance distribution, real field goal attempts only
# =============================================================
fg_events <- c("shot", "miss")
FGA <- subset(PbP.BDB, event_type %in% fg_events & !is.na(shot_distance))
cat("Real field goal attempts with a real shot_distance recorded:", nrow(FGA), "\n")

FGA$made <- as.integer(FGA$event_type == "shot")
FGA$dist_ft <- as.numeric(as.character(FGA$shot_distance))
FGA <- subset(FGA, !is.na(dist_ft))
FGA$dist_m <- FGA$dist_ft * 0.3048
cat("Real field goal attempts with a valid numeric real shot_distance:", nrow(FGA), "\n")

summary_dist <- summary(FGA$dist_ft)
print(summary_dist)
write.csv(data.frame(stat = names(summary_dist), value = round(as.numeric(summary_dist), 2)),
          file.path(out_dir, "module7_shot_distance_summary.csv"), row.names = FALSE)

# Real FG% by distance bucket (2 ft bins out to 30 ft)
FGA$dist_bucket <- cut(FGA$dist_ft, breaks = seq(0, 34, by = 2), include.lowest = TRUE, right = FALSE)
fg_by_dist <- FGA %>%
  filter(!is.na(dist_bucket)) %>%
  group_by(dist_bucket) %>%
  summarise(n = n(), real_fg_pct = round(100 * mean(made), 1)) %>%
  filter(n >= 100)
print(fg_by_dist)
write.csv(fg_by_dist, file.path(out_dir, "module7_real_fg_pct_by_distance_bucket.csv"), row.names = FALSE)

png(file.path(out_dir, "module7_real_fg_pct_by_distance.png"), width = 1900, height = 1300, res = 150)
plot(as.numeric(fg_by_dist$dist_bucket) * 2 - 1, fg_by_dist$real_fg_pct, type = "b", pch = 19,
     xlab = "Real shot distance (feet, 2-ft buckets)", ylab = "Real field goal percentage",
     main = "Real 2017-18 FG% by Real Shot Distance")
dev.off()

# =============================================================
# PART 2: Real physics -- minimum-speed trajectory at real representative distances
# =============================================================
g <- 9.8            # standard gravity, m/s^2
rim_h <- 3.048       # real regulation rim height, 10 ft, in meters
release_h <- 2.1336  # 7 ft, a commonly cited real average NBA release height
                      # (Coach Dave Love, "Launch Angle and Velocity in Basketball Shooting")
y_rise <- rim_h - release_h

real_distances_ft <- c(4, 10, 15, 19.75, 23.75, 28)  # rim-adjacent, real median 2PA-ish,
                                                       # real FT line, real long 2, real NBA 3PT, real deep 3
names(real_distances_ft) <- c("At the rim", "Real mid-range (10 ft)", "Free throw line (15 ft)",
                               "Long two (19.75 ft)", "NBA three-point line (23.75 ft)", "Deep three (28 ft)")

traj <- data.frame(
  shot_type = names(real_distances_ft),
  distance_ft = as.numeric(real_distances_ft)
)
traj$distance_m <- traj$distance_ft * 0.3048
traj$theta_min_deg <- 45 + 0.5 * (180 / pi) * atan(y_rise / traj$distance_m)
traj$v_min_ms <- sqrt(g * (traj$distance_m + sqrt(traj$distance_m^2 + y_rise^2)))
traj$v_min_mph <- traj$v_min_ms * 2.23694

print(traj)
write.csv(traj, file.path(out_dir, "module7_real_minimum_speed_trajectories.csv"), row.names = FALSE)

png(file.path(out_dir, "module7_real_theta_min_vs_distance.png"), width = 1900, height = 1300, res = 150)
plot(traj$distance_ft, traj$theta_min_deg, type = "b", pch = 19, col = "darkred",
     xlab = "Real shot distance (feet)", ylab = "Real theoretical minimum-speed launch angle (degrees)",
     main = "Real Minimum-Speed Launch Angle vs. Real Shot Distance",
     ylim = c(min(traj$theta_min_deg) - 2, max(traj$theta_min_deg) + 2))
dev.off()

# =============================================================
# PART 3: Real computed angle vs. real published entry-angle research (contrast)
# =============================================================
published <- data.frame(
  shot_type = c("Free throw line (15 ft)", "NBA three-point line (23.75 ft)"),
  real_published_launch_angle_deg_7ft_release = c(55.2, 64.1)
)
compare_tab <- merge(traj[, c("shot_type", "distance_ft", "theta_min_deg")], published, by = "shot_type")
names(compare_tab)[names(compare_tab) == "theta_min_deg"] <- "real_theoretical_minimum_speed_angle_deg"
print(compare_tab)
write.csv(compare_tab, file.path(out_dir, "module7_theory_vs_published_angle_comparison.csv"), row.names = FALSE)

# =============================================================
# PART 4: Real hang time (time of flight) at the same real representative distances
# =============================================================
traj$time_of_flight_s <- with(traj, {
  vx <- v_min_ms * cos(theta_min_deg * pi / 180)
  distance_m / vx
})
print(traj[, c("shot_type", "distance_ft", "theta_min_deg", "v_min_mph", "time_of_flight_s")])
write.csv(traj, file.path(out_dir, "module7_real_minimum_speed_trajectories_full.csv"), row.names = FALSE)

cat("\nDONE MODULE 7 (GRADUATE) COMPUTATION\n")
sink()
cat("Log written to", log_file, "\n")
