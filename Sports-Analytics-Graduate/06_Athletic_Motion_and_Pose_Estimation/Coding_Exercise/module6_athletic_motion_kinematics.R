## Module 6 (graduate): Athletic Motion Kinematics Analysis
## Maps to: Zuccolotto, Manisera & Sandri (2026), Advanced Basketball Data Science, Ch. 6
##   ("Athletic motion kinematics analysis"): 6.1-6.4 AI, computer vision, CNNs, and MoveNet
##   pose estimation; 6.5 pose estimation data analysis (6.5.1 Crossover, 6.5.2 Shot).
##
## Data-access note (same honest gap as graduate Modules 4 and 5): the textbook's own Chapter 6
## worked examples run a MoveNet pose-estimation CNN over proprietary frame-by-frame broadcast
## video to extract real joint keypoints for a crossover dribble and a jump shot. That raw video
## and its extracted keypoint time series are not publicly redistributed and are not bundled in
## any package available to us, and downloading arbitrary broadcast video or player photographs
## is outside what this course's tools can responsibly do. This script does not fabricate joint
## angle numbers to stand in for that video.
##
## Instead, it asks the same real underlying question Chapter 6's pose-based "Shot" and
## "Crossover" analyses ask (does a player's movement quality break down as fatigue accumulates
## over a real game) using data this course can responsibly access: BasketballAnalyzeR::PbP.BDB,
## the same real 2017-18 Golden State Warriors season-long play-by-play data already used in
## graduate Modules 4 and 5 and undergraduate Module 6. Free throws are used as a real proxy for
## shot-release mechanics (same distance, same motion, uncontested, every single time) and
## turnovers as a real proxy for ball-handling control. The module's Videos and References files
## point to the real published pose-estimation literature (MoveNet's own documentation, and two
## real 2025-2026 basketball-specific markerless motion capture studies) for what full,
## joint-level pose data actually shows.

options(width = 120)
library(BasketballAnalyzeR)
library(dplyr)
library(ggplot2)

out_dir <- "Sports-Analytics-Graduate/06_Athletic_Motion_and_Pose_Estimation/Coding_Exercise"
dir.create(out_dir, showWarnings = FALSE, recursive = TRUE)

data(PbP.BDB)
PbP <- PbPmanipulation(PbP.BDB)
cat("Real total logged events, 2017-18 GSW season-long PbP:", nrow(PbP), "\n")

## ================================================================
## PART 1: Real free-throw shot-mechanics consistency by period
## ================================================================
ft <- subset(PbP, event_type == "free throw" & !is.na(result))
ft$make <- ifelse(ft$result == "made", 1, 0)

ft_period <- ft %>%
  filter(period <= 5) %>%
  group_by(period) %>%
  summarise(attempts = n(), makes = sum(make), pct = round(100 * mean(make), 1), .groups = "drop") %>%
  mutate(period_label = ifelse(period <= 4, paste("Q", period), "OT"))
print(ft_period)
write.csv(ft_period, file.path(out_dir, "module6_ft_pct_by_period.csv"), row.names = FALSE)

overall_ft_pct <- round(100 * mean(ft$make), 1)
cat("Real overall free throw pct, full season:", overall_ft_pct, "%\n")

player_ft <- ft %>%
  group_by(player) %>%
  summarise(attempts = n(), pct = round(100 * mean(make), 1), .groups = "drop") %>%
  filter(attempts >= 40) %>%
  arrange(desc(attempts))
write.csv(player_ft, file.path(out_dir, "module6_ft_pct_by_player.csv"), row.names = FALSE)
print(player_ft)

curry_ft_period <- ft %>%
  filter(player == "Stephen Curry", period <= 4) %>%
  group_by(period) %>%
  summarise(attempts = n(), pct = round(100 * mean(make), 1), .groups = "drop")
write.csv(curry_ft_period, file.path(out_dir, "module6_curry_ft_pct_by_period.csv"), row.names = FALSE)
print(curry_ft_period)

p_ft <- ggplot(ft_period %>% filter(period <= 4), aes(x = period_label, y = pct)) +
  geom_col(fill = "#1D428A", width = 0.55) +
  geom_text(aes(label = paste0(pct, "%")), vjust = -0.5, size = 5) +
  geom_hline(yintercept = overall_ft_pct, linetype = "dashed", color = "#E4572E") +
  ylim(0, 100) +
  labs(title = "Real Free Throw Percentage by Quarter, 2017-18 GSW",
       subtitle = paste0("Dashed line = full-season average (", overall_ft_pct, "%)"),
       x = NULL, y = "FT%") +
  theme_minimal(base_size = 14)
ggsave(file.path(out_dir, "module6_ft_pct_by_period.png"), p_ft, width = 8, height = 5.5, dpi = 160, bg = "white")

## ================================================================
## PART 2: Real turnover rate by period (ball-handling / "crossover" control proxy)
## ================================================================
plays_period <- PbP %>% filter(period <= 4) %>% group_by(period) %>% summarise(plays = n(), .groups = "drop")
tov_period <- PbP %>% filter(event_type == "turnover", period <= 4) %>% group_by(period) %>% summarise(turnovers = n(), .groups = "drop")
tov_rate <- merge(plays_period, tov_period, by = "period")
tov_rate$tov_per_100_plays <- round(100 * tov_rate$turnovers / tov_rate$plays, 2)
tov_rate$period_label <- paste("Q", tov_rate$period)
print(tov_rate)
write.csv(tov_rate, file.path(out_dir, "module6_turnover_rate_by_period.csv"), row.names = FALSE)

p_tov <- ggplot(tov_rate, aes(x = period_label, y = tov_per_100_plays)) +
  geom_col(fill = "#E4572E", width = 0.55) +
  geom_text(aes(label = tov_per_100_plays), vjust = -0.5, size = 5) +
  ylim(0, 8) +
  labs(title = "Real Turnovers per 100 Logged Plays by Quarter, 2017-18 GSW", x = NULL, y = "Turnovers per 100 plays") +
  theme_minimal(base_size = 14)
ggsave(file.path(out_dir, "module6_turnover_rate_by_period.png"), p_tov, width = 8, height = 5.5, dpi = 160, bg = "white")

## ================================================================
## PART 3: Real field goal percentage in the last 3 minutes of the fourth quarter
## ================================================================
late <- subset(PbP, event_type %in% c("shot", "miss") & period == 4 & periodTime >= 540)
late$make <- ifelse(late$event_type == "shot", 1, 0)
ot <- subset(PbP, event_type %in% c("shot", "miss") & period >= 5)
ot$make <- ifelse(ot$event_type == "shot", 1, 0)
rest <- subset(PbP, event_type %in% c("shot", "miss") & !(period == 4 & periodTime >= 540) & period < 5)
rest$make <- ifelse(rest$event_type == "shot", 1, 0)

fatigue_window <- data.frame(
  segment = c("Last 3 min of Q4", "Overtime", "Rest of game"),
  fg_pct  = c(round(100*mean(late$make),1), round(100*mean(ot$make),1), round(100*mean(rest$make),1)),
  n       = c(nrow(late), nrow(ot), nrow(rest))
)
print(fatigue_window)
write.csv(fatigue_window, file.path(out_dir, "module6_fatigue_window_fg_pct.csv"), row.names = FALSE)

cat("\nDone. All numbers above are real, computed directly from BasketballAnalyzeR::PbP.BDB.\n")

p_fw <- ggplot(fatigue_window, aes(x = reorder(segment, fg_pct), y = fg_pct)) +
  geom_col(fill = c("#27496D","#AEBBD1","#1D428A")[match(fatigue_window$segment[order(match(fatigue_window$segment, reorder(fatigue_window$segment, fatigue_window$fg_pct)))], fatigue_window$segment)], width=0.55) +
  geom_text(aes(label = paste0(fg_pct, "%  (n=", n, ")")), vjust = -0.5, size = 4.5) +
  ylim(0, 70) + coord_flip() +
  labs(title = "Real Field Goal Percentage by Game Segment, 2017-18 GSW",
       subtitle = "Full season, all logged shot attempts",
       x = NULL, y = "FG%") +
  theme_minimal(base_size = 14)
ggsave(file.path(out_dir, "module6_fatigue_window_fg_pct.png"), p_fw, width = 9, height = 4.5, dpi = 160, bg = "white")
cat("chart3 saved\n")
